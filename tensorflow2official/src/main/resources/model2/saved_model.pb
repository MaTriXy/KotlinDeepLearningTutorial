��
    ��
:
Add
x"T
y"T
z"T"
Ttype: 
2   
�
ArgMax

input"T
dimension"Tidx
output"output_type"
Ttype: 
2
"
Tidxtype0: 
    2  "
output_typetype0: 
2
x
Assign
ref"T�

value"T

output_ref"T�"
Ttype"
validate_shapebool("
use_lockingbool(�
~
BiasAdd

value"T	
bias"T
output"T"
Ttype: 
2
"-
data_formatstringNHWC: 
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
�
Conv2D

input"T
filter"T
output"T"
Ttype: 
2"
strides  list(int)"
use_cudnn_on_gpubool(""
paddingstring: 

SAMEVALID"-
data_formatstringNHWC: 
NHWCNCHW"
dilations  list(int)
    
    ^
Fill
dims"
index_type

value"T
output"T"
Ttype"

index_typetype0: 
    2
    .
Identity

input"T
output"T"
Ttype
p
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:
    2
    �
    MaxPool

input"T
output"T"
Ttype0: 

    2    "
ksize  list(int)(0"
strides  list(int)(0""
paddingstring: 

SAMEVALID":
data_formatstringNHWC: 
NHWCNCHW NCHW_VECT_C
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(�
=
Mul
x"T
y"T
z"T"
Ttype: 
2   �

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape: 
~

RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype: 
2"
Ttype: 
2  �
D
Relu
features"T
activations"T"
Ttype: 
2   
[
Reshape
tensor"T
shape"Tshape
output"T"
Ttype"
Tshapetype0: 
2
o
RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
H
ShardedFilename
basename
shard

num_shards
filename
9
Softmax
logits"T
softmax"T"
Ttype: 
2
N

StringJoin
inputs*N

output"
Nint(0"
separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype: 
2   
s

VariableV2
ref"dtype�"
shapeshape"
dtypetype"
containerstring "
shared_namestring �"serve*1.8.02v1.8.0-0-g93bc2e2072��

global_step/Initializer/zerosConst*
_class
loc: @global_step*
value  B   R *
dtype0  *
_output_shapes
:  
�
global_step
VariableV2*
container *
shape:  *
dtype0  *
_output_shapes
:  *
shared_name *
_class
loc: @global_step
�
global_step/AssignAssign global_stepglobal_step/Initializer/zeros*
_output_shapes
:  *
use_locking(*
T0  *
_class
loc: @global_step*
validate_shape(
j
global_step/readIdentity global_step*
T0  *
_class
loc: @global_step*
_output_shapes
:  
v
Placeholder Placeholder*
shape:  ���������*
dtype0*+
_output_shapes
    :  ���������
f

Reshape/shapeConst*
_output_shapes
    : *%
valueB"����         *
    dtype0
v
ReshapeReshape Placeholder
Reshape/shape*
T0*
Tshape0*/
_output_shapes
    :  ���������
    �
.conv2d/kernel/Initializer/random_uniform/shapeConst*
_class
loc: @conv2d/kernel*%
valueB"             *
    dtype0*
_output_shapes
    : 
    �
, conv2d/kernel/Initializer/random_uniform/minConst*
_class
loc: @conv2d/kernel*
value B
 *n���*
dtype0*
_output_shapes
:  
�
, conv2d/kernel/Initializer/random_uniform/maxConst*
_output_shapes
:  *
_class
loc: @conv2d/kernel*
value B
 *n��=*
dtype0
�
6conv2d/kernel/Initializer/random_uniform/RandomUniform
RandomUniform.conv2d/kernel/Initializer/random_uniform/shape*

seed *
T0*
_class
loc: @conv2d/kernel*
seed2 *
dtype0*&
_output_shapes
    : 
    �
, conv2d/kernel/Initializer/random_uniform/subSub, conv2d/kernel/Initializer/random_uniform/max, conv2d/kernel/Initializer/random_uniform/min*
T0*
_class
loc: @conv2d/kernel*
_output_shapes
:  
�
, conv2d/kernel/Initializer/random_uniform/mulMul6conv2d/kernel/Initializer/random_uniform/RandomUniform, conv2d/kernel/Initializer/random_uniform/sub*
T0*
_class
loc: @conv2d/kernel*&
_output_shapes
    : 
    �
(conv2d/kernel/Initializer/random_uniformAdd, conv2d/kernel/Initializer/random_uniform/mul, conv2d/kernel/Initializer/random_uniform/min*
T0*
_class
loc: @conv2d/kernel*&
_output_shapes
    : 
    �

conv2d/kernel
VariableV2*
_class
loc: @conv2d/kernel*
container *
shape:  *
    dtype0*&
_output_shapes
    :  *
shared_name 
�
conv2d/kernel/AssignAssign
conv2d/kernel(conv2d/kernel/Initializer/random_uniform*
use_locking(*
T0*
_class
loc: @conv2d/kernel*
validate_shape(*&
_output_shapes
    : 
    �
conv2d/kernel/readIdentity
conv2d/kernel*&
_output_shapes
    :  *
T0*
_class
loc: @conv2d/kernel
�
conv2d/bias/Initializer/zerosConst*
_class
loc: @conv2d/bias*
valueB *    *
dtype0*
_output_shapes
: 
�
conv2d/bias
VariableV2*
shape:  *
dtype0*
_output_shapes
:  *
shared_name *
_class
loc: @conv2d/bias*
container 
�
conv2d/bias/AssignAssign conv2d/biasconv2d/bias/Initializer/zeros*
_output_shapes
:  *
use_locking(*
T0*
_class
loc: @conv2d/bias*
validate_shape(
n
conv2d/bias/readIdentity conv2d/bias*
T0*
_class
loc: @conv2d/bias*
_output_shapes
: 
e
conv2d/dilation_rateConst*
valueB"      *
    dtype0*
_output_shapes
    : 
    �

conv2d/Conv2DConv2DReshapeconv2d/kernel/read*/
_output_shapes
    :  ��������� *
dilations
    *
T0*
data_formatNHWC*
strides
    *
use_cudnn_on_gpu(*
paddingSAME
�
conv2d/BiasAddBiasAdd
conv2d/Conv2Dconv2d/bias/read*
T0*
data_formatNHWC*/
_output_shapes
    :  ���������
]
conv2d/ReluReluconv2d/BiasAdd*/
_output_shapes
    :  ��������� *
    T0
�
max_pooling2d/MaxPoolMaxPool conv2d/Relu*
T0*
data_formatNHWC*
strides
    *
ksize
    *
paddingVALID*/
_output_shapes
    :  ���������
    �
    0conv2d_1/kernel/Initializer/random_uniform/shapeConst*
_output_shapes
    : *"
_class
loc: @conv2d_1/kernel*%
valueB"          @   *
    dtype0
�
.conv2d_1/kernel/Initializer/random_uniform/minConst*"
_class
loc: @conv2d_1/kernel*
value B
 *��L�*
dtype0*
_output_shapes
:  
�
.conv2d_1/kernel/Initializer/random_uniform/maxConst*"
_class
loc: @conv2d_1/kernel*
value B
 *��L=*
dtype0*
_output_shapes
:  
�
8conv2d_1/kernel/Initializer/random_uniform/RandomUniform
RandomUniform0conv2d_1/kernel/Initializer/random_uniform/shape*"
_class
loc: @conv2d_1/kernel*
seed2 *
dtype0*&
_output_shapes
    :  @*

seed *
T0
�
.conv2d_1/kernel/Initializer/random_uniform/subSub.conv2d_1/kernel/Initializer/random_uniform/max.conv2d_1/kernel/Initializer/random_uniform/min*
_output_shapes
:  *
T0*"
_class
loc: @conv2d_1/kernel
�
.conv2d_1/kernel/Initializer/random_uniform/mulMul8conv2d_1/kernel/Initializer/random_uniform/RandomUniform.conv2d_1/kernel/Initializer/random_uniform/sub*
T0*"
_class
loc: @conv2d_1/kernel*&
_output_shapes
    :  @
    �
*conv2d_1/kernel/Initializer/random_uniformAdd.conv2d_1/kernel/Initializer/random_uniform/mul.conv2d_1/kernel/Initializer/random_uniform/min*
T0*"
_class
loc: @conv2d_1/kernel*&
_output_shapes
    :  @
    �
conv2d_1/kernel
VariableV2*"
_class
loc: @conv2d_1/kernel*
container *
shape:  @*
    dtype0*&
_output_shapes
    :  @*
shared_name 
�
conv2d_1/kernel/AssignAssignconv2d_1/kernel*conv2d_1/kernel/Initializer/random_uniform*"
_class
loc: @conv2d_1/kernel*
validate_shape(*&
_output_shapes
    :  @*
use_locking(*
T0
�
conv2d_1/kernel/readIdentityconv2d_1/kernel*&
_output_shapes
    :  @*
T0*"
_class
loc: @conv2d_1/kernel
�
conv2d_1/bias/Initializer/zerosConst*
dtype0*
_output_shapes
    : @*
    _class
loc: @conv2d_1/bias*
valueB@*    
�

conv2d_1/bias
VariableV2*
shape: @*
dtype0*
_output_shapes
    : @*
shared_name *
_class
loc: @conv2d_1/bias*
container 
�
conv2d_1/bias/AssignAssign
conv2d_1/biasconv2d_1/bias/Initializer/zeros*
use_locking(*
T0*
_class
loc: @conv2d_1/bias*
validate_shape(*
_output_shapes
: @
t
conv2d_1/bias/readIdentity
conv2d_1/bias*
T0*
_class
loc: @conv2d_1/bias*
_output_shapes
: @
g
conv2d_1/dilation_rateConst*
valueB"      *
    dtype0*
_output_shapes
    : 
    �
conv2d_1/Conv2DConv2Dmax_pooling2d/MaxPoolconv2d_1/kernel/read*/
_output_shapes
    :  ���������@*
dilations
    *
T0*
data_formatNHWC*
strides
    *
use_cudnn_on_gpu(*
paddingSAME
�
conv2d_1/BiasAddBiasAddconv2d_1/Conv2Dconv2d_1/bias/read*/
_output_shapes
    :  ���������@*
T0*
data_formatNHWC
a

conv2d_1/ReluReluconv2d_1/BiasAdd*/
_output_shapes
    :  ���������@*
T0
�
max_pooling2d_1/MaxPoolMaxPool
conv2d_1/Relu*
T0*
data_formatNHWC*
strides
    *
ksize
    *
paddingVALID*/
_output_shapes
    :  ���������@
    `
    Reshape_1/shapeConst*
valueB"����@  *
    dtype0*
_output_shapes
: 

Reshape_1Reshapemax_pooling2d_1/MaxPoolReshape_1/shape*
T0*
Tshape0*(
_output_shapes
    :  ����������
�
-dense/kernel/Initializer/random_uniform/shapeConst*
_class
loc: @dense/kernel*
valueB"@     *
    dtype0*
_output_shapes
    : 
    �
+dense/kernel/Initializer/random_uniform/minConst*
_class
loc: @dense/kernel*
value B
 *���*
dtype0*
_output_shapes
:  
�
+dense/kernel/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
:  *
_class
loc: @dense/kernel*
value B
 *��=
    �
5dense/kernel/Initializer/random_uniform/RandomUniform
RandomUniform-dense/kernel/Initializer/random_uniform/shape*
T0*
_class
loc: @dense/kernel*
seed2 *
dtype0*
_output_shapes
    :
    ��*

seed 
�
+dense/kernel/Initializer/random_uniform/subSub+dense/kernel/Initializer/random_uniform/max+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc: @dense/kernel*
_output_shapes
:  
�
+dense/kernel/Initializer/random_uniform/mulMul5dense/kernel/Initializer/random_uniform/RandomUniform+dense/kernel/Initializer/random_uniform/sub*
T0*
_class
loc: @dense/kernel*
_output_shapes
    :
    ��
�
'dense/kernel/Initializer/random_uniformAdd+dense/kernel/Initializer/random_uniform/mul+dense/kernel/Initializer/random_uniform/min* 
_output_shapes
    :
    ��*
T0*
_class
loc: @dense/kernel
�
dense/kernel
VariableV2*
dtype0*
_output_shapes
    :
    ��*
shared_name *
_class
loc: @dense/kernel*
container *
shape :
    ��
�
dense/kernel/AssignAssign dense/kernel'dense/kernel/Initializer/random_uniform*
T0*
_class
loc: @dense/kernel*
validate_shape(*
_output_shapes
    :
    ��*
use_locking(
w
dense/kernel/readIdentity dense/kernel*
_class
loc: @dense/kernel*
_output_shapes
    :
    ��*
T0
�
, dense/bias/Initializer/zeros/shape_as_tensorConst*
dtype0*
_output_shapes
    : *
_class
loc: @dense/bias*
valueB : �
�
"dense/bias/Initializer/zeros/ConstConst*
dtype0*
_output_shapes
:  *
_class
loc: @dense/bias*
value B
 *    
    �
dense/bias/Initializer/zerosFill, dense/bias/Initializer/zeros/shape_as_tensor"dense/bias/Initializer/zeros/Const*
_output_shapes
: �*
T0*
_class
loc: @dense/bias*

index_type0
�

dense/bias
VariableV2*
shared_name *
_class
loc: @dense/bias*
container *
shape: �*
    dtype0*
_output_shapes
: �
    �
dense/bias/AssignAssign
dense/biasdense/bias/Initializer/zeros*
_output_shapes
: �*
use_locking(*
T0*
_class
loc: @dense/bias*
validate_shape(
l
dense/bias/readIdentity
dense/bias*
T0*
_class
loc: @dense/bias*
_output_shapes
: �
    �
dense/MatMulMatMul  Reshape_1dense/kernel/read*(
_output_shapes
    :  ����������*
transpose_a( *
transpose_b( *
T0
�

dense/BiasAddBiasAdd dense/MatMuldense/bias/read*
T0*
data_formatNHWC*(
_output_shapes
    :  ����������
T

dense/ReluRelu
dense/BiasAdd*(
_output_shapes
    :  ����������*
T0
[
dropout/IdentityIdentity
dense/Relu*(
_output_shapes
    :  ����������*
T0
�
/dense_1/kernel/Initializer/random_uniform/shapeConst*!
_class
loc: @dense_1/kernel*
valueB"   
       *
dtype0*
_output_shapes
    : 
    �
-dense_1/kernel/Initializer/random_uniform/minConst*
dtype0*
_output_shapes
:  *!
_class
loc: @dense_1/kernel*
value B
 *���
    �
-dense_1/kernel/Initializer/random_uniform/maxConst*!
_class
loc: @dense_1/kernel*
value B
 *��=*
dtype0*
_output_shapes
:  
�
7dense_1/kernel/Initializer/random_uniform/RandomUniform
RandomUniform/dense_1/kernel/Initializer/random_uniform/shape*
dtype0*
_output_shapes
: �
    *

seed *
T0*!
_class
loc: @dense_1/kernel*
seed2 
�
-dense_1/kernel/Initializer/random_uniform/subSub-dense_1/kernel/Initializer/random_uniform/max-dense_1/kernel/Initializer/random_uniform/min*
T0*!
_class
loc: @dense_1/kernel*
_output_shapes
:  
�
-dense_1/kernel/Initializer/random_uniform/mulMul7dense_1/kernel/Initializer/random_uniform/RandomUniform-dense_1/kernel/Initializer/random_uniform/sub*
T0*!
_class
loc: @dense_1/kernel*
_output_shapes
: �

    �
)dense_1/kernel/Initializer/random_uniformAdd-dense_1/kernel/Initializer/random_uniform/mul-dense_1/kernel/Initializer/random_uniform/min*
T0*!
_class
loc: @dense_1/kernel*
_output_shapes
: �

    �
dense_1/kernel
VariableV2*
shared_name *!
_class
loc: @dense_1/kernel*
container *
shape : �
    *
dtype0*
_output_shapes
: �

    �
dense_1/kernel/AssignAssigndense_1/kernel)dense_1/kernel/Initializer/random_uniform*
use_locking(*
T0*!
_class
loc: @dense_1/kernel*
validate_shape(*
_output_shapes
: �

    |
dense_1/kernel/readIdentitydense_1/kernel*
_output_shapes
: �
    *
T0*!
_class
loc: @dense_1/kernel
�
dense_1/bias/Initializer/zerosConst*
_class
loc: @dense_1/bias*
valueB
    *    *
dtype0*
_output_shapes
: 

�
dense_1/bias
VariableV2*
container *
shape: 
*
dtype0*
_output_shapes
: 
*
shared_name *
_class
loc: @dense_1/bias
�
dense_1/bias/AssignAssign dense_1/biasdense_1/bias/Initializer/zeros*
validate_shape(*
_output_shapes
: 
*
use_locking(*
T0*
_class
loc: @dense_1/bias
q
dense_1/bias/readIdentity dense_1/bias*
T0*
_class
loc: @dense_1/bias*
_output_shapes
    : 

    �
    dense_1/MatMulMatMuldropout/Identitydense_1/kernel/read*'
_output_shapes
    :  ���������
    *
transpose_a( *
transpose_b( *
T0
�
dense_1/BiasAddBiasAdddense_1/MatMuldense_1/bias/read*
data_formatNHWC*'
_output_shapes
    :  ���������
    *
T0
R
ArgMax/dimensionConst*
value  B : *
dtype0*
_output_shapes
:  
�
ArgMaxArgMaxdense_1/BiasAddArgMax/dimension*
output_type0  *#
_output_shapes
    :
     ���������*

Tidx0*
T0
\
softmax_tensorSoftmaxdense_1/BiasAdd*
T0*'
_output_shapes
    :  ���������

P

save/ConstConst*
value
B  Bmodel*
dtype0*
_output_shapes
:  
�
save/StringJoin/inputs_1Const*<
value3B1 B+_temp_e937564f9137497fbed7da9570f259ff/part*
dtype0*
_output_shapes
:  
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
separator *
N*
_output_shapes
:  
Q
save/num_shardsConst*
value  B : *
dtype0*
_output_shapes
:  
k
save/ShardedFilename/shardConst"
/device: CPU:0*
value  B :  *
dtype0*
_output_shapes
:  
�
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"
/device: CPU:0*
_output_shapes
:  
�
save/SaveV2/tensor_namesConst"
/device: CPU:0*�
value�B�  B conv2d/biasB
conv2d/kernelB
conv2d_1/biasBconv2d_1/kernelB
dense/biasB dense/kernelB dense_1/biasBdense_1/kernelB global_step*
dtype0*
_output_shapes
    : 
    �
    save/SaveV2/shape_and_slicesConst"
/device: CPU:0*
_output_shapes
    :   *%
    valueB  B B B B B B B B B *
dtype0
�
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slices conv2d/bias
conv2d/kernel
conv2d_1/biasconv2d_1/kernel
dense/bias dense/kernel dense_1/biasdense_1/kernel global_step"
/device: CPU:0*
dtypes
2  
    �
save/control_dependencyIdentitysave/ShardedFilename ^save/SaveV2"
/device: CPU:0*
_output_shapes
:  *
T0*'
_class
loc: @save/ShardedFilename
�
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"
/device: CPU:0*
T0*

axis *
N*
_output_shapes
    : 
    �
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"
/device: CPU:0*
delete_old_dirs(
�

save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"
/device: CPU:0*
_output_shapes
:  *
T0
�
save/RestoreV2/tensor_namesConst"
/device: CPU:0*
dtype0*
_output_shapes
    :   *�
value�B�  B conv2d/biasB
conv2d/kernelB
conv2d_1/biasBconv2d_1/kernelB
dense/biasB dense/kernelB dense_1/biasBdense_1/kernelB global_step
�
save/RestoreV2/shape_and_slicesConst"
/device: CPU:0*%
valueB  B B B B B B B B B *
dtype0*
_output_shapes
    : 
    �
    save/RestoreV2  RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"
/device: CPU:0*
dtypes
2    *8
_output_shapes&
    $: : : : : : : : : 
    �
save/AssignAssign conv2d/biassave/RestoreV2*
T0*
_class
loc: @conv2d/bias*
validate_shape(*
_output_shapes
:  *
use_locking(
�

save/Assign_1Assign
conv2d/kernelsave/RestoreV2: 1*
_class
loc: @conv2d/kernel*
validate_shape(*&
_output_shapes
    :  *
use_locking(*
T0
�

save/Assign_2Assign
conv2d_1/biassave/RestoreV2: 2*
use_locking(*
T0*
_class
loc: @conv2d_1/bias*
validate_shape(*
_output_shapes
    : @
    �

save/Assign_3Assignconv2d_1/kernelsave/RestoreV2: 3*
use_locking(*
T0*"
_class
loc: @conv2d_1/kernel*
validate_shape(*&
_output_shapes
    :  @
    �

save/Assign_4Assign
dense/biassave/RestoreV2: 4*
validate_shape(*
_output_shapes
: �*
use_locking(*
T0*
_class
loc: @dense/bias
�

save/Assign_5Assign dense/kernelsave/RestoreV2: 5*
_output_shapes
    :
    ��*
use_locking(*
T0*
_class
loc: @dense/kernel*
validate_shape(
�

save/Assign_6Assign dense_1/biassave/RestoreV2: 6*
use_locking(*
T0*
_class
loc: @dense_1/bias*
validate_shape(*
_output_shapes
: 

�

save/Assign_7Assigndense_1/kernelsave/RestoreV2: 7*
use_locking(*
T0*!
_class
loc: @dense_1/kernel*
validate_shape(*
_output_shapes
: �

    �

save/Assign_8Assign global_stepsave/RestoreV2: 8*
use_locking(*
T0  *
_class
loc: @global_step*
validate_shape(*
_output_shapes
:  
�
save/restore_shardNoOp ^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8
-
save/restore_allNoOp^save/restore_shard

initNoOp

init_all_tablesNoOp

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
R
save_1/ConstConst*
value
B  Bmodel*
dtype0*
_output_shapes
:  
�
save_1/StringJoin/inputs_1Const*
_output_shapes
:  *<
value3B1 B+_temp_6702c08e5f9644a88d67bcd49531a27c/part*
dtype0
{
save_1/StringJoin
    StringJoin save_1/Constsave_1/StringJoin/inputs_1*
    N*
    _output_shapes
    :  *
    separator 
    S
    save_1/num_shardsConst*
    value  B : *
    dtype0*
    _output_shapes
    :  
    m
    save_1/ShardedFilename/shardConst"
    /device: CPU: 0*
        value  B :  *
    dtype0*
    _output_shapes
    :  
    �
    save_1/ShardedFilenameShardedFilenamesave_1/StringJoinsave_1/ShardedFilename/shardsave_1/num_shards"
    /device: CPU: 0*
    _output_shapes
    :  
    �
    save_1/SaveV2/tensor_namesConst"
    /device: CPU: 0*�
        value�B�  B conv2d/biasB
    conv2d/kernelB
    conv2d_1/biasBconv2d_1/kernelB
    dense/biasB dense/kernelB dense_1/biasBdense_1/kernelB global_step*
    dtype0*
    _output_shapes
    : 
    �
    save_1/SaveV2/shape_and_slicesConst"
    /device: CPU: 0*%
    valueB  B B B B B B B B B *
    dtype0*
    _output_shapes
    : 
    �

    save_1/SaveV2SaveV2save_1/ShardedFilenamesave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slices conv2d/bias
    conv2d/kernel
    conv2d_1/biasconv2d_1/kernel
    dense/bias dense/kernel dense_1/biasdense_1/kernel global_step"
    /device: CPU:0*
    dtypes
    2  
    �
    save_1/control_dependencyIdentitysave_1/ShardedFilename^save_1/SaveV2"
    /device: CPU: 0*
    T0*)
    _class
    loc: @save_1/ShardedFilename*
    _output_shapes
    :  
    �
    -save_1/MergeV2Checkpoints/checkpoint_prefixesPacksave_1/ShardedFilename^save_1/control_dependency"
    /device:CPU: 0*
    T0*

    axis *
    N*
        _output_shapes
    : 
    �
    save_1/MergeV2CheckpointsMergeV2Checkpoints-save_1/MergeV2Checkpoints/checkpoint_prefixes save_1/Const"
    /device: CPU: 0*
        delete_old_dirs(
    �
    save_1/IdentityIdentity save_1/Const^save_1/MergeV2Checkpoints^save_1/control_dependency"
    /device: CPU: 0*
        _output_shapes
    :  *
    T0
    �
    save_1/RestoreV2/tensor_namesConst"
    /device: CPU:0*�
    value�B�  B conv2d/biasB
    conv2d/kernelB
    conv2d_1/biasBconv2d_1/kernelB
    dense/biasB dense/kernelB dense_1/biasBdense_1/kernelB global_step*
    dtype0*
    _output_shapes
    : 
        �
        !save_1/RestoreV2/shape_and_slicesConst"
    /device: CPU: 0*
    dtype0*
    _output_shapes
    :   *%
    valueB  B B B B B B B B B 
    �
    save_1/RestoreV2  RestoreV2 save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices"
    /device: CPU: 0*8
    _output_shapes&
    $: : : : : : : : : *
    dtypes
    2  
    �

    save_1/AssignAssign conv2d/biassave_1/RestoreV2*
    _output_shapes
    :  *
    use_locking(*
    T0*
    _class
    loc: @conv2d/bias*
    validate_shape(
    �
    save_1/Assign_1Assign
    conv2d/kernelsave_1/RestoreV2: 1*&
    _output_shapes
    :  *
    use_locking(*
    T0*
    _class
    loc: @conv2d/kernel*
    validate_shape(
    �
    save_1/Assign_2Assign
    conv2d_1/biassave_1/RestoreV2: 2*
    use_locking(*
    T0*
    _class
        loc: @conv2d_1/bias*
    validate_shape(*
    _output_shapes
    : @
    �
    save_1/Assign_3Assignconv2d_1/kernelsave_1/RestoreV2: 3*
    T0*"
    _class
    loc: @conv2d_1/kernel*
    validate_shape(*&
        _output_shapes
    :  @*
    use_locking(
    �
    save_1/Assign_4Assign
    dense/biassave_1/RestoreV2: 4*
    _class
    loc: @dense/bias*
    validate_shape(*
    _output_shapes
    : �*
    use_locking(*
    T0
    �
    save_1/Assign_5Assign dense/kernelsave_1/RestoreV2: 5*
    T0*
        _class
    loc: @dense/kernel*
    validate_shape(*
    _output_shapes
        :
        ��*
    use_locking(
    �
    save_1/Assign_6Assign dense_1/biassave_1/RestoreV2: 6*
    use_locking(*
    T0*
    _class
    loc: @dense_1/bias*
    validate_shape(*
    _output_shapes
    : 

    �
    save_1/Assign_7Assigndense_1/kernelsave_1/RestoreV2: 7*
    use_locking(*
    T0*!
    _class
        loc: @dense_1/kernel*
    validate_shape(*
    _output_shapes
    : �

    �
    save_1/Assign_8Assign global_stepsave_1/RestoreV2: 8*
    use_locking(*
    T0  *
    _class
    loc: @global_step*
    validate_shape(*
    _output_shapes
        :  
        �
        save_1/restore_shardNoOp^save_1/Assign^save_1/Assign_1^save_1/Assign_2^save_1/Assign_3^save_1/Assign_4^save_1/Assign_5^save_1/Assign_6^save_1/Assign_7^save_1/Assign_8
        1
            save_1/restore_allNoOp^save_1/restore_shard"B
        save_1/Const:0save_1/Identity: 0save_1/restore_all (5 @F8"�
    trainable_variables��
    i
    conv2d/kernel: 0conv2d/kernel/Assignconv2d/kernel/read: 02*conv2d/kernel/Initializer/random_uniform: 0
    X

    conv2d/bias: 0conv2d/bias/Assignconv2d/bias/read: 02conv2d/bias/Initializer/zeros: 0
    q
    conv2d_1/kernel: 0conv2d_1/kernel/Assignconv2d_1/kernel/read: 02,conv2d_1/kernel/Initializer/random_uniform: 0
    `
    conv2d_1/bias: 0conv2d_1/bias/Assignconv2d_1/bias/read: 02!conv2d_1/bias/Initializer/zeros: 0
    e
    dense/kernel: 0dense/kernel/Assigndense/kernel/read: 02)dense/kernel/Initializer/random_uniform: 0
    T
    dense/bias:0dense/bias/Assigndense/bias/read: 02dense/bias/Initializer/zeros: 0
    m
    dense_1/kernel: 0dense_1/kernel/Assigndense_1/kernel/read: 02+dense_1/kernel/Initializer/random_uniform: 0
    \
        dense_1/bias: 0dense_1/bias/Assigndense_1/bias/read: 02 dense_1/bias/Initializer/zeros: 0"k
    global_step\Z
    X

    global_step: 0global_step/Assignglobal_step/read: 02global_step/Initializer/zeros: 0"�
    variables��
    X

        global_step: 0global_step/Assignglobal_step/read: 02global_step/Initializer/zeros: 0
    i
    conv2d/kernel:0conv2d/kernel/Assignconv2d/kernel/read: 02*conv2d/kernel/Initializer/random_uniform: 0
    X

    conv2d/bias: 0conv2d/bias/Assignconv2d/bias/read: 02conv2d/bias/Initializer/zeros: 0
    q
    conv2d_1/kernel: 0conv2d_1/kernel/Assignconv2d_1/kernel/read: 02, conv2d_1/kernel/Initializer/random_uniform: 0
    `
    conv2d_1/bias: 0conv2d_1/bias/Assignconv2d_1/bias/read: 02!conv2d_1/bias/Initializer/zeros: 0
    e
    dense/kernel: 0dense/kernel/Assigndense/kernel/read: 02)dense/kernel/Initializer/random_uniform: 0
    T
    dense/bias: 0dense/bias/Assigndense/bias/read: 02dense/bias/Initializer/zeros: 0
    m
        dense_1/kernel: 0dense_1/kernel/Assigndense_1/kernel/read: 02+dense_1/kernel/Initializer/random_uniform: 0
    \
    dense_1/bias: 0dense_1/bias/Assigndense_1/bias/read: 02 dense_1/bias/Initializer/zeros: 0"
    legacy_init_op


    group_deps*�
        classify�
        1
    image(

        Placeholder: 0 ���������8

    probabilities'
    softmax_tensor: 0 ���������
    &
    classes
    ArgMax: 0  
     ���������tensorflow/serving/predict*�
    serving_default�
    1
    image(

    Placeholder: 0 ���������8

    probabilities'
    softmax_tensor: 0 ���������
    &
    classes
        ArgMax: 0  
     ���������tensorflow/serving/predict
