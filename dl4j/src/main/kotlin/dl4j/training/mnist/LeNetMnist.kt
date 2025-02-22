package dl4j.training.mnist

import dl4j.DataUtilities
import dl4j.MNIST_Example
import org.datavec.api.io.labels.ParentPathLabelGenerator
import org.datavec.api.split.FileSplit
import org.datavec.image.loader.NativeImageLoader
import org.datavec.image.recordreader.ImageRecordReader
import org.deeplearning4j.datasets.datavec.RecordReaderDataSetIterator
import org.deeplearning4j.eval.Evaluation
import org.deeplearning4j.nn.conf.BackpropType
import org.deeplearning4j.nn.conf.MultiLayerConfiguration
import org.deeplearning4j.nn.conf.NeuralNetConfiguration
import org.deeplearning4j.nn.conf.inputs.InputType
import org.deeplearning4j.nn.conf.layers.ConvolutionLayer
import org.deeplearning4j.nn.conf.layers.DenseLayer
import org.deeplearning4j.nn.conf.layers.OutputLayer
import org.deeplearning4j.nn.conf.layers.SubsamplingLayer
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork
import org.deeplearning4j.nn.weights.WeightInit
import org.deeplearning4j.optimize.listeners.ScoreIterationListener
import org.deeplearning4j.util.ModelSerializer
import org.nd4j.linalg.activations.Activation
import org.nd4j.linalg.dataset.api.iterator.DataSetIterator
import org.nd4j.linalg.dataset.api.preprocessor.ImagePreProcessingScaler
import org.nd4j.linalg.learning.config.Nesterovs
import org.nd4j.linalg.lossfunctions.LossFunctions
import org.nd4j.linalg.schedule.MapSchedule
import org.nd4j.linalg.schedule.ScheduleType
import java.io.File
import java.util.*

private const val height = 28L
private const val width = 28L
private const val channels = 1L // single channel for grayscale images
private const val outputNum = 10 // 10 digits classification
private const val batchSize = 54
private const val nEpochs = 3
private const val seed = 1234
private val randNumGen = Random(seed.toLong())

/**
 * Implementation of LeNet-5 for handwritten digits image classification on MNIST dataset (99% accuracy)
 * <a href="http://yann.lecun.com/exdb/publis/pdf/lecun-01a.pdf">[LeCun et al., 1998. Gradient based learning applied to document recognition]</a>
 * Some minor changes are made to the architecture like using ReLU and identity activation instead of
 * sigmoid/tanh, max pooling instead of avg pooling and softmax output layer.
 */
fun main() {
    val (trainIter: DataSetIterator, testIter: DataSetIterator) = preprocessTrainTestDatasets()

    val lrSchedule = setUpLearningRateSchedule()

    val net = initNeuralNetwork(lrSchedule)

    println("Starting training")

    // evaluation while training (the score should go down)
    for (i in 0 until nEpochs) {
        net.fit(trainIter)
        println("Completed epoch $i")
        val eval = net.evaluate<Evaluation>(testIter)
        println(eval.stats())
        trainIter.reset()
        testIter.reset()
    }

    ModelSerializer.writeModel(net, File(MNIST_Example.basePath + "/minist-model.zip"), true)
}

private fun preprocessTrainTestDatasets(): Pair<DataSetIterator, DataSetIterator> {
    MNIST_Example.log.info("Data load and vectorization...")

    val localFilePath = MNIST_Example.basePath + "/mnist_png.tar.gz"

    if (DataUtilities.downloadFile(
            MNIST_Example.dataUrl,
            localFilePath
        )
    ) MNIST_Example.log.debug(
        "Data downloaded from {}",
        MNIST_Example.dataUrl
    )
    if (!File(MNIST_Example.basePath + "/mnist_png").exists()) DataUtilities.extractTarGz(
        localFilePath,
        MNIST_Example.basePath
    )

    // vectorization of train data
    val trainData = File(MNIST_Example.basePath + "/mnist_png/training")
    val trainSplit = FileSplit(
        trainData, NativeImageLoader.ALLOWED_FORMATS,
        randNumGen
    )
    val labelMaker = ParentPathLabelGenerator() // parent path as the image label
    val trainRR = ImageRecordReader(
        height,
        width,
        channels, labelMaker
    )

    trainRR.initialize(trainSplit)

    val trainIter: DataSetIterator = RecordReaderDataSetIterator(
        trainRR,
        batchSize, 1,
        outputNum
    )

    // pixel values from 0-255 to 0-1 (min-max scaling)
    val scaler = ImagePreProcessingScaler(0.0, 1.0)
    scaler.fit(trainIter)
    trainIter.preProcessor = scaler

    // vectorization of test data
    val testData = File(MNIST_Example.basePath + "/mnist_png/testing")
    val testSplit = FileSplit(
        testData, NativeImageLoader.ALLOWED_FORMATS,
        randNumGen
    )
    val testRR = ImageRecordReader(
        height,
        width,
        channels, labelMaker
    )
    testRR.initialize(testSplit)
    val testIter: DataSetIterator = RecordReaderDataSetIterator(
        testRR,
        batchSize, 1,
        outputNum
    )
    testIter.preProcessor = scaler // same normalization for better results
    return Pair(trainIter, testIter)
}

private fun setUpLearningRateSchedule(): MutableMap<Int, Double> {
    val lrSchedule: MutableMap<Int, Double> = HashMap()
    lrSchedule[0] = 0.06 // iteration #, learning rate
    lrSchedule[200] = 0.05
    lrSchedule[600] = 0.028
    lrSchedule[800] = 0.0060
    lrSchedule[1000] = 0.001
    return lrSchedule
}

private fun initNeuralNetwork(
    lrSchedule: MutableMap<Int, Double>
): MultiLayerNetwork {
    val nnArchitecture = defineNeuralNetwork(lrSchedule)

    val net = MultiLayerNetwork(nnArchitecture)
    net.init()
    net.setListeners(ScoreIterationListener(10))
    //net.setListeners(StatsListener(statsStorage))
    println("Total num of params:" + net.numParams())
    return net
}

private fun defineNeuralNetwork(
    lrSchedule: MutableMap<Int, Double>
): MultiLayerConfiguration? {
    return NeuralNetConfiguration.Builder()
        .seed(seed.toLong())
        .l2(0.0005)
        .updater(Nesterovs(MapSchedule(ScheduleType.ITERATION, lrSchedule)))
        .weightInit(WeightInit.XAVIER)
        .list()
        .layer(
            0, ConvolutionLayer.Builder(5, 5)
                .nIn(channels)
                .stride(1, 1)
                .nOut(20)
                .activation(Activation.IDENTITY)
                .build()
        )
        .layer(
            1,
            SubsamplingLayer.Builder(SubsamplingLayer.PoolingType.MAX)
                .kernelSize(2, 2)
                .stride(2, 2)
                .build()
        )
        .layer(
            2, ConvolutionLayer.Builder(5, 5)
                .stride(1, 1) // nIn need not specified in later layers
                .nOut(50)
                .activation(Activation.IDENTITY)
                .build()
        )
        .layer(
            3,
            SubsamplingLayer.Builder(SubsamplingLayer.PoolingType.MAX)
                .kernelSize(2, 2)
                .stride(2, 2)
                .build()
        )
        .layer(
            4,
            DenseLayer.Builder().activation(Activation.RELU)
                .nOut(500).build()
        )
        .layer(
            5,
            OutputLayer.Builder(LossFunctions.LossFunction.NEGATIVELOGLIKELIHOOD)
                .nOut(outputNum)
                .activation(Activation.SOFTMAX)
                .build()
        )
        .setInputType(
            InputType.convolutionalFlat(
                28,
                28,
                1
            )
        ) // InputType.convolutional for normal image
        .backpropType(BackpropType.Standard).build()
}