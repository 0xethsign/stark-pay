%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int216, warp_external_input_check_int256, warp_external_input_check_int8
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.uint256 import Uint256
from warplib.memory import wm_new
from warplib.maths.utils import felt_to_uint256
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, fixed_bytes_to_felt_dynamic_array, felt_array_to_warp_memory_array
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address, get_contract_address
from warplib.maths.sub import warp_sub, warp_sub256
from warplib.maths.exp import warp_exp256
from starkware.cairo.common.dict_access import DictAccess
from warplib.keccak import warp_keccak
from warplib.maths.gt import warp_gt
from warplib.maths.eq import warp_eq256
from warplib.block_methods import warp_block_timestamp
from warplib.maths.int_conversions import warp_uint256, warp_int256_to_int40
from warplib.maths.mul_unsafe import warp_mul_unsafe256
from warplib.maths.add import warp_add216, warp_add256
from warplib.maths.neq import warp_neq256
from warplib.maths.ge import warp_ge256
from warplib.maths.sub_unsafe import warp_sub_unsafe256, warp_sub_unsafe216
from warplib.maths.div_unsafe import warp_div_unsafe256
from warplib.maths.add_unsafe import warp_add_unsafe256
from warplib.maths.mod import warp_mod256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.mul import warp_mul256
from warplib.maths.div import warp_div256
from warplib.maths.mul_signed import warp_mul_signed256
from warplib.maths.sub_signed import warp_sub_signed256
from warplib.maths.div_signed import warp_div_signed256


struct Payer_977769af{
    lastPayerUpdate : felt,
    totalPaidPerSec : felt,
}


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func WSM0_Payer_977769af_lastPayerUpdate(loc: felt) -> (memberLoc: felt){
    return (loc,);
}

func WSM1_Payer_977769af_totalPaidPerSec(loc: felt) -> (memberLoc: felt){
    return (loc + 1,);
}

func WS0_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}

func WS1_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}

func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}

func extern_input_check0{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
warp_external_input_check_int8(ptr[0]);
   extern_input_check0(len = len - 1, ptr = ptr + 1);
    return ();
}

func cd_to_memory0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata: felt*, mem_start: felt, length: felt){
    alloc_locals;
    if (length == 0){
        return ();
    }
dict_write{dict_ptr=warp_memory}(mem_start, calldata[0]);
    return cd_to_memory0_elem(calldata + 1, mem_start + 1, length - 1);
}
func cd_to_memory0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata : cd_dynarray_felt) -> (mem_loc: felt){
    alloc_locals;
    let (len256) = felt_to_uint256(calldata.len);
    let (mem_start) = wm_new(len256, Uint256(0x1, 0x0));
    cd_to_memory0_elem(calldata.ptr, mem_start + 2, calldata.len);
    return (mem_start,);
}

func abi_encode_packed0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256, param1 : Uint256, param2 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let (bytes_array : felt*) = alloc();
fixed_bytes256_to_felt_dynamic_array(bytes_index,bytes_array,0,param0);
let bytes_index = bytes_index +  32;
fixed_bytes256_to_felt_dynamic_array(bytes_index,bytes_array,0,param1);
let bytes_index = bytes_index +  32;
fixed_bytes_to_felt_dynamic_array(bytes_index,bytes_array,0,param2,27);
let bytes_index = bytes_index +  27;
  let (max_length256) = felt_to_uint256(bytes_index);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_index);
  return (mem_ptr,);
}

@storage_var
func WARP_MAPPING0(name: felt, index: Uint256) -> (resLoc : felt){
}
func WS0_INDEX_Uint256_to_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING0.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_MAPPING0.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

@storage_var
func WARP_MAPPING1(name: felt, index: felt) -> (resLoc : felt){
}
func WS1_INDEX_felt_to_Payer_977769af{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING1.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_MAPPING1.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

@storage_var
func WARP_MAPPING2(name: felt, index: felt) -> (resLoc : felt){
}
func WS2_INDEX_felt_to_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING2.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_MAPPING2.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}


// Contract Def LlamaPay


@event
func StreamCreated_bdf2ad45(__warp_5_from : felt, to : felt, amountPerSec : felt, streamId : Uint256){
}


@event
func StreamCreatedWithReason_f9b31dda(__warp_6_from : felt, to : felt, amountPerSec : felt, streamId : Uint256, reason : felt){
}


@event
func StreamCancelled_6841f88c(__warp_7_from : felt, to : felt, amountPerSec : felt, streamId : Uint256){
}


@event
func StreamPaused_ad944a97(__warp_8_from : felt, to : felt, amountPerSec : felt, streamId : Uint256){
}


@event
func StreamModified_0edc6e7e(__warp_9_from : felt, oldTo : felt, oldAmountPerSec : felt, oldStreamId : Uint256, to : felt, amountPerSec : felt, newStreamId : Uint256){
}


@event
func Withdraw_674faf74(__warp_10_from : felt, to : felt, amountPerSec : felt, streamId : Uint256, amount : Uint256){
}


@event
func PayerDeposit_3de3aee7(__warp_11_from : felt, amount : Uint256){
}


@event
func PayerWithdraw_b67efc8b(__warp_12_from : felt, amount : Uint256){
}

namespace LlamaPay{

    // Dynamic variables - Arrays and Maps

    const __warp_0_streamToStart = 1;

    const __warp_1_payers = 2;

    const __warp_2_balances = 3;

    // Static variables

    const __warp_3_token = 3;

    const __warp_4_DECIMALS_DIVISOR = 4;


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
        let (__warp_se_0) = get_caller_address();
        
        let (__warp_pse_0) = Factory_warped_interface.parameter_ad4d4e29(__warp_se_0);
        
        WS_WRITE0(__warp_3_token, __warp_pse_0);
        
        let (__warp_se_1) = WS0_READ_felt(__warp_3_token);
        
        let (__warp_13_tokenDecimals) = IERC20WithDecimals_warped_interface.decimals_313ce567(__warp_se_1);
        
        let (__warp_se_2) = warp_sub(20, __warp_13_tokenDecimals);
        
        let (__warp_se_3) = warp_exp256(Uint256(low=10, high=0), __warp_se_2);
        
        WS_WRITE1(__warp_4_DECIMALS_DIVISOR, __warp_se_3);
        
        
        
        return ();

    }


    func getStreamId_a05860e0_internal{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_14_from : felt, __warp_15_to : felt, __warp_16_amountPerSec : felt)-> (__warp_17 : Uint256){
    alloc_locals;


        
        let (__warp_18_f) = felt_to_uint256(__warp_14_from);
        
        let (__warp_19_t) = felt_to_uint256(__warp_15_to);
        
        let (__warp_se_4) = abi_encode_packed0(__warp_18_f, __warp_19_t, __warp_16_amountPerSec);
        
        let (__warp_se_5) = warp_keccak(__warp_se_4);
        
        
        
        return (__warp_se_5,);

    }


    func _createStream_ac90cfe6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_20_to : felt, __warp_21_amountPerSec : felt)-> (__warp_22_streamId : Uint256){
    alloc_locals;


        
        let __warp_22_streamId = Uint256(low=0, high=0);
        
        let (__warp_se_6) = get_caller_address();
        
        let (__warp_pse_1) = getStreamId_a05860e0_internal(__warp_se_6, __warp_20_to, __warp_21_amountPerSec);
        
        let __warp_22_streamId = __warp_pse_1;
        
        let (__warp_se_7) = warp_gt(__warp_21_amountPerSec, 0);
        
        with_attr error_message("amountPerSec can't be 0"){
            assert __warp_se_7 = 1;
        }
        
        let (__warp_se_8) = WS0_INDEX_Uint256_to_Uint256(__warp_0_streamToStart, __warp_22_streamId);
        
        let (__warp_se_9) = WS1_READ_Uint256(__warp_se_8);
        
        let (__warp_se_10) = warp_eq256(__warp_se_9, Uint256(low=0, high=0));
        
        with_attr error_message("stream already exists"){
            assert __warp_se_10 = 1;
        }
        
        let (__warp_se_11) = WS0_INDEX_Uint256_to_Uint256(__warp_0_streamToStart, __warp_22_streamId);
        
        let (__warp_se_12) = warp_block_timestamp();
        
        WS_WRITE1(__warp_se_11, __warp_se_12);
        
        let (__warp_se_13) = get_caller_address();
        
        let (__warp_23_payer) = WS1_INDEX_felt_to_Payer_977769af(__warp_1_payers, __warp_se_13);
        
        let __warp_24_totalPaid = Uint256(low=0, high=0);
        
        let (__warp_se_14) = warp_block_timestamp();
        
        let (__warp_se_15) = WSM0_Payer_977769af_lastPayerUpdate(__warp_23_payer);
        
        let (__warp_se_16) = WS0_READ_felt(__warp_se_15);
        
        let (__warp_se_17) = warp_uint256(__warp_se_16);
        
        let (__warp_25_delta) = warp_sub256(__warp_se_14, __warp_se_17);
        
            
            let (__warp_se_18) = WSM1_Payer_977769af_totalPaidPerSec(__warp_23_payer);
            
            let (__warp_se_19) = WS0_READ_felt(__warp_se_18);
            
            let (__warp_se_20) = warp_uint256(__warp_se_19);
            
            let (__warp_se_21) = warp_mul_unsafe256(__warp_25_delta, __warp_se_20);
            
            let __warp_24_totalPaid = __warp_se_21;
        
        let (__warp_cs_0) = get_caller_address();
        
        let (__warp_se_22) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_cs_0);
        
        let (__warp_se_23) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_cs_0);
        
        let (__warp_se_24) = WS1_READ_Uint256(__warp_se_23);
        
        let (__warp_se_25) = warp_sub256(__warp_se_24, __warp_24_totalPaid);
        
        WS_WRITE1(__warp_se_22, __warp_se_25);
        
        let (__warp_se_26) = WSM0_Payer_977769af_lastPayerUpdate(__warp_23_payer);
        
        let (__warp_se_27) = warp_block_timestamp();
        
        let (__warp_se_28) = warp_int256_to_int40(__warp_se_27);
        
        WS_WRITE0(__warp_se_26, __warp_se_28);
        
        let (__warp_se_29) = WSM1_Payer_977769af_totalPaidPerSec(__warp_23_payer);
        
        let (__warp_se_30) = WSM1_Payer_977769af_totalPaidPerSec(__warp_23_payer);
        
        let (__warp_se_31) = WS0_READ_felt(__warp_se_30);
        
        let (__warp_se_32) = warp_add216(__warp_se_31, __warp_21_amountPerSec);
        
        WS_WRITE0(__warp_se_29, __warp_se_32);
        
        
        
        return (__warp_22_streamId,);

    }


    func createStream_c355f343_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_26_to : felt, __warp_27_amountPerSec : felt)-> (){
    alloc_locals;


        
        let (__warp_28_streamId) = _createStream_ac90cfe6(__warp_26_to, __warp_27_amountPerSec);
        
        let (__warp_se_33) = get_caller_address();
        
        StreamCreated_bdf2ad45.emit(__warp_se_33, __warp_26_to, __warp_27_amountPerSec, __warp_28_streamId);
        
        
        
        return ();

    }


    func createStreamWithReason_8835510c_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_29_to : felt, __warp_30_amountPerSec : felt, __warp_31_reason : cd_dynarray_felt)-> (){
    alloc_locals;


        
        let (__warp_32_streamId) = _createStream_ac90cfe6(__warp_29_to, __warp_30_amountPerSec);
        
        let (__warp_se_34) = get_caller_address();
        
        let (__warp_se_35) = cd_to_memory0(__warp_31_reason);
        
        StreamCreatedWithReason_f9b31dda.emit(__warp_se_34, __warp_29_to, __warp_30_amountPerSec, __warp_32_streamId, __warp_se_35);
        
        
        
        return ();

    }


    func _withdraw_c2f417c8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_33_from : felt, __warp_34_to : felt, __warp_35_amountPerSec : felt)-> (__warp_36_lastUpdate : felt, __warp_37_streamId : Uint256, __warp_38_amountToTransfer : Uint256){
    alloc_locals;


        
        let __warp_38_amountToTransfer = Uint256(low=0, high=0);
        
        let __warp_36_lastUpdate = 0;
        
        let __warp_37_streamId = Uint256(low=0, high=0);
        
        let (__warp_pse_2) = getStreamId_a05860e0_internal(__warp_33_from, __warp_34_to, __warp_35_amountPerSec);
        
        let __warp_37_streamId = __warp_pse_2;
        
        let (__warp_se_36) = WS0_INDEX_Uint256_to_Uint256(__warp_0_streamToStart, __warp_37_streamId);
        
        let (__warp_se_37) = WS1_READ_Uint256(__warp_se_36);
        
        let (__warp_se_38) = warp_neq256(__warp_se_37, Uint256(low=0, high=0));
        
        with_attr error_message("stream doesn't exist"){
            assert __warp_se_38 = 1;
        }
        
        let (__warp_39_payer) = WS1_INDEX_felt_to_Payer_977769af(__warp_1_payers, __warp_33_from);
        
        let __warp_40_totalPayerPayment = Uint256(low=0, high=0);
        
        let (__warp_se_39) = warp_block_timestamp();
        
        let (__warp_se_40) = WSM0_Payer_977769af_lastPayerUpdate(__warp_39_payer);
        
        let (__warp_se_41) = WS0_READ_felt(__warp_se_40);
        
        let (__warp_se_42) = warp_uint256(__warp_se_41);
        
        let (__warp_41_payerDelta) = warp_sub256(__warp_se_39, __warp_se_42);
        
            
            let (__warp_se_43) = WSM1_Payer_977769af_totalPaidPerSec(__warp_39_payer);
            
            let (__warp_se_44) = WS0_READ_felt(__warp_se_43);
            
            let (__warp_se_45) = warp_uint256(__warp_se_44);
            
            let (__warp_se_46) = warp_mul_unsafe256(__warp_41_payerDelta, __warp_se_45);
            
            let __warp_40_totalPayerPayment = __warp_se_46;
        
        let (__warp_se_47) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_33_from);
        
        let (__warp_42_payerBalance) = WS1_READ_Uint256(__warp_se_47);
        
        let (__warp_se_48) = warp_ge256(__warp_42_payerBalance, __warp_40_totalPayerPayment);
        
        if (__warp_se_48 != 0){
        
            
                
                    
                    let (__warp_se_49) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_33_from);
                    
                    let (__warp_se_50) = warp_sub_unsafe256(__warp_42_payerBalance, __warp_40_totalPayerPayment);
                    
                    WS_WRITE1(__warp_se_49, __warp_se_50);
                
                let (__warp_se_51) = warp_block_timestamp();
                
                let (__warp_se_52) = warp_int256_to_int40(__warp_se_51);
                
                let __warp_36_lastUpdate = __warp_se_52;
            
            let (__warp_36_lastUpdate, __warp_37_streamId, __warp_38_amountToTransfer) = _withdraw_c2f417c8_if_part1(__warp_36_lastUpdate, __warp_37_streamId, __warp_38_amountToTransfer, __warp_35_amountPerSec, __warp_33_from, __warp_34_to);
            
            
            
            return (__warp_36_lastUpdate, __warp_37_streamId, __warp_38_amountToTransfer);
        }else{
        
            
                
                    
                    let (__warp_se_53) = WSM1_Payer_977769af_totalPaidPerSec(__warp_39_payer);
                    
                    let (__warp_se_54) = WS0_READ_felt(__warp_se_53);
                    
                    let (__warp_se_55) = warp_uint256(__warp_se_54);
                    
                    let (__warp_43_timePaid) = warp_div_unsafe256(__warp_42_payerBalance, __warp_se_55);
                    
                    let (__warp_se_56) = WSM0_Payer_977769af_lastPayerUpdate(__warp_39_payer);
                    
                    let (__warp_se_57) = WS0_READ_felt(__warp_se_56);
                    
                    let (__warp_se_58) = warp_uint256(__warp_se_57);
                    
                    let (__warp_se_59) = warp_add_unsafe256(__warp_se_58, __warp_43_timePaid);
                    
                    let (__warp_se_60) = warp_int256_to_int40(__warp_se_59);
                    
                    let __warp_36_lastUpdate = __warp_se_60;
                    
                    let (__warp_se_61) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_33_from);
                    
                    let (__warp_se_62) = WSM1_Payer_977769af_totalPaidPerSec(__warp_39_payer);
                    
                    let (__warp_se_63) = WS0_READ_felt(__warp_se_62);
                    
                    let (__warp_se_64) = warp_uint256(__warp_se_63);
                    
                    let (__warp_se_65) = warp_mod256(__warp_42_payerBalance, __warp_se_64);
                    
                    WS_WRITE1(__warp_se_61, __warp_se_65);
            
            let (__warp_36_lastUpdate, __warp_37_streamId, __warp_38_amountToTransfer) = _withdraw_c2f417c8_if_part1(__warp_36_lastUpdate, __warp_37_streamId, __warp_38_amountToTransfer, __warp_35_amountPerSec, __warp_33_from, __warp_34_to);
            
            
            
            return (__warp_36_lastUpdate, __warp_37_streamId, __warp_38_amountToTransfer);
        }

    }


    func _withdraw_c2f417c8_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_36_lastUpdate : felt, __warp_37_streamId : Uint256, __warp_38_amountToTransfer : Uint256, __warp_35_amountPerSec : felt, __warp_33_from : felt, __warp_34_to : felt)-> (__warp_36_lastUpdate : felt, __warp_37_streamId : Uint256, __warp_38_amountToTransfer : Uint256){
    alloc_locals;


        
        let (__warp_se_66) = warp_uint256(__warp_36_lastUpdate);
        
        let (__warp_se_67) = WS0_INDEX_Uint256_to_Uint256(__warp_0_streamToStart, __warp_37_streamId);
        
        let (__warp_se_68) = WS1_READ_Uint256(__warp_se_67);
        
        let (__warp_44_delta) = warp_sub256(__warp_se_66, __warp_se_68);
        
            
            let (__warp_se_69) = warp_uint256(__warp_35_amountPerSec);
            
            let (__warp_se_70) = warp_mul_unsafe256(__warp_44_delta, __warp_se_69);
            
            let (__warp_se_71) = WS1_READ_Uint256(__warp_4_DECIMALS_DIVISOR);
            
            let (__warp_se_72) = warp_div_unsafe256(__warp_se_70, __warp_se_71);
            
            let __warp_38_amountToTransfer = __warp_se_72;
        
        Withdraw_674faf74.emit(__warp_33_from, __warp_34_to, __warp_35_amountPerSec, __warp_37_streamId, __warp_38_amountToTransfer);
        
        let __warp_36_lastUpdate = __warp_36_lastUpdate;
        
        let __warp_37_streamId = __warp_37_streamId;
        
        let __warp_38_amountToTransfer = __warp_38_amountToTransfer;
        
        
        
        return (__warp_36_lastUpdate, __warp_37_streamId, __warp_38_amountToTransfer);

    }


    func withdrawable_3f053acd_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_49_lastUpdate : Uint256, __warp_51_streamId : Uint256, __warp_48_withdrawableAmount : Uint256, __warp_47_amountPerSec : felt, __warp_50_owed : Uint256)-> (__warp_48_withdrawableAmount : Uint256, __warp_49_lastUpdate : Uint256, __warp_50_owed : Uint256){
    alloc_locals;


        
        let (__warp_se_94) = WS0_INDEX_Uint256_to_Uint256(__warp_0_streamToStart, __warp_51_streamId);
        
        let (__warp_se_95) = WS1_READ_Uint256(__warp_se_94);
        
        let (__warp_57_delta) = warp_sub256(__warp_49_lastUpdate, __warp_se_95);
        
        let (__warp_se_96) = warp_uint256(__warp_47_amountPerSec);
        
        let (__warp_se_97) = warp_mul256(__warp_57_delta, __warp_se_96);
        
        let (__warp_se_98) = WS1_READ_Uint256(__warp_4_DECIMALS_DIVISOR);
        
        let (__warp_se_99) = warp_div256(__warp_se_97, __warp_se_98);
        
        let __warp_48_withdrawableAmount = __warp_se_99;
        
        let (__warp_se_100) = warp_block_timestamp();
        
        let (__warp_se_101) = warp_sub256(__warp_se_100, __warp_49_lastUpdate);
        
        let (__warp_se_102) = warp_uint256(__warp_47_amountPerSec);
        
        let (__warp_se_103) = warp_mul256(__warp_se_101, __warp_se_102);
        
        let (__warp_se_104) = WS1_READ_Uint256(__warp_4_DECIMALS_DIVISOR);
        
        let (__warp_se_105) = warp_div256(__warp_se_103, __warp_se_104);
        
        let __warp_50_owed = __warp_se_105;
        
        let __warp_48_withdrawableAmount = __warp_48_withdrawableAmount;
        
        let __warp_49_lastUpdate = __warp_49_lastUpdate;
        
        let __warp_50_owed = __warp_50_owed;
        
        
        
        return (__warp_48_withdrawableAmount, __warp_49_lastUpdate, __warp_50_owed);

    }


    func _cancelStream_a574052c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_64_to : felt, __warp_65_amountPerSec : felt)-> (__warp_66_streamId : Uint256){
    alloc_locals;


        
        let __warp_66_streamId = Uint256(low=0, high=0);
        
        let __warp_67_lastUpdate = 0;
        
        let __warp_68_amountToTransfer = Uint256(low=0, high=0);
        
            
            let (__warp_se_111) = get_caller_address();
            
            let (__warp_tv_0, __warp_tv_1, __warp_tv_2) = _withdraw_c2f417c8(__warp_se_111, __warp_64_to, __warp_65_amountPerSec);
            
            let __warp_68_amountToTransfer = __warp_tv_2;
            
            let __warp_66_streamId = __warp_tv_1;
            
            let __warp_67_lastUpdate = __warp_tv_0;
        
        let (__warp_se_112) = WS0_INDEX_Uint256_to_Uint256(__warp_0_streamToStart, __warp_66_streamId);
        
        WS_WRITE1(__warp_se_112, Uint256(low=0, high=0));
        
        let (__warp_se_113) = get_caller_address();
        
        let (__warp_69_payer) = WS1_INDEX_felt_to_Payer_977769af(__warp_1_payers, __warp_se_113);
        
            
            let (__warp_se_114) = WSM1_Payer_977769af_totalPaidPerSec(__warp_69_payer);
            
            let (__warp_se_115) = WSM1_Payer_977769af_totalPaidPerSec(__warp_69_payer);
            
            let (__warp_se_116) = WS0_READ_felt(__warp_se_115);
            
            let (__warp_se_117) = warp_sub_unsafe216(__warp_se_116, __warp_65_amountPerSec);
            
            WS_WRITE0(__warp_se_114, __warp_se_117);
        
        let (__warp_se_118) = WSM0_Payer_977769af_lastPayerUpdate(__warp_69_payer);
        
        WS_WRITE0(__warp_se_118, __warp_67_lastUpdate);
        
        let (__warp_se_119) = WS0_READ_felt(__warp_3_token);
        
        IERC20_warped_interface.transfer_a9059cbb(__warp_se_119, __warp_64_to, __warp_68_amountToTransfer);
        
        
        
        return (__warp_66_streamId,);

    }


    func deposit_b6b55f25_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_82_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_cs_1) = get_caller_address();
        
        let (__warp_se_123) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_cs_1);
        
        let (__warp_se_124) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_cs_1);
        
        let (__warp_se_125) = WS1_READ_Uint256(__warp_se_124);
        
        let (__warp_se_126) = WS1_READ_Uint256(__warp_4_DECIMALS_DIVISOR);
        
        let (__warp_se_127) = warp_mul256(__warp_82_amount, __warp_se_126);
        
        let (__warp_se_128) = warp_add256(__warp_se_125, __warp_se_127);
        
        WS_WRITE1(__warp_se_123, __warp_se_128);
        
        let (__warp_se_129) = WS0_READ_felt(__warp_3_token);
        
        let (__warp_se_130) = get_caller_address();
        
        let (__warp_se_131) = get_contract_address();
        
        IERC20_warped_interface.transferFrom_23b872dd(__warp_se_129, __warp_se_130, __warp_se_131, __warp_82_amount);
        
        let (__warp_se_132) = get_caller_address();
        
        PayerDeposit_3de3aee7.emit(__warp_se_132, __warp_82_amount);
        
        
        
        return ();

    }


    func withdrawPayer_bfda0b45_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_90_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_133) = get_caller_address();
        
        let (__warp_91_payer) = WS1_INDEX_felt_to_Payer_977769af(__warp_1_payers, __warp_se_133);
        
        let (__warp_cs_2) = get_caller_address();
        
        let (__warp_se_134) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_cs_2);
        
        let (__warp_se_135) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_cs_2);
        
        let (__warp_se_136) = WS1_READ_Uint256(__warp_se_135);
        
        let (__warp_se_137) = warp_sub256(__warp_se_136, __warp_90_amount);
        
        WS_WRITE1(__warp_se_134, __warp_se_137);
        
        let (__warp_se_138) = warp_block_timestamp();
        
        let (__warp_se_139) = WSM0_Payer_977769af_lastPayerUpdate(__warp_91_payer);
        
        let (__warp_se_140) = WS0_READ_felt(__warp_se_139);
        
        let (__warp_se_141) = warp_uint256(__warp_se_140);
        
        let (__warp_92_delta) = warp_sub256(__warp_se_138, __warp_se_141);
        
            
            let (__warp_se_142) = get_caller_address();
            
            let (__warp_se_143) = WS2_INDEX_felt_to_Uint256(__warp_2_balances, __warp_se_142);
            
            let (__warp_se_144) = WS1_READ_Uint256(__warp_se_143);
            
            let (__warp_se_145) = WSM1_Payer_977769af_totalPaidPerSec(__warp_91_payer);
            
            let (__warp_se_146) = WS0_READ_felt(__warp_se_145);
            
            let (__warp_se_147) = warp_uint256(__warp_se_146);
            
            let (__warp_se_148) = warp_mul_unsafe256(__warp_92_delta, __warp_se_147);
            
            let (__warp_se_149) = warp_ge256(__warp_se_144, __warp_se_148);
            
            with_attr error_message("pls no rug"){
                assert __warp_se_149 = 1;
            }
            
            let (__warp_se_150) = WS1_READ_Uint256(__warp_4_DECIMALS_DIVISOR);
            
            let (__warp_93_tokenAmount) = warp_div_unsafe256(__warp_90_amount, __warp_se_150);
            
            let (__warp_se_151) = WS0_READ_felt(__warp_3_token);
            
            let (__warp_se_152) = get_caller_address();
            
            IERC20_warped_interface.transfer_a9059cbb(__warp_se_151, __warp_se_152, __warp_93_tokenAmount);
            
            let (__warp_se_153) = get_caller_address();
            
            PayerWithdraw_b67efc8b.emit(__warp_se_153, __warp_93_tokenAmount);
        
        
        
        return ();

    }

}


    @view
    func withdrawable_3f053acd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_45_from : felt, __warp_46_to : felt, __warp_47_amountPerSec : felt)-> (__warp_48_withdrawableAmount : Uint256, __warp_49_lastUpdate : Uint256, __warp_50_owed : Uint256){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_47_amountPerSec);
        
        warp_external_input_check_address(__warp_46_to);
        
        warp_external_input_check_address(__warp_45_from);
        
        let __warp_50_owed = Uint256(low=0, high=0);
        
        let __warp_48_withdrawableAmount = Uint256(low=0, high=0);
        
        let __warp_49_lastUpdate = Uint256(low=0, high=0);
        
        let (__warp_51_streamId) = LlamaPay.getStreamId_a05860e0_internal(__warp_45_from, __warp_46_to, __warp_47_amountPerSec);
        
        let (__warp_se_73) = WS0_INDEX_Uint256_to_Uint256(LlamaPay.__warp_0_streamToStart, __warp_51_streamId);
        
        let (__warp_se_74) = WS1_READ_Uint256(__warp_se_73);
        
        let (__warp_se_75) = warp_neq256(__warp_se_74, Uint256(low=0, high=0));
        
        with_attr error_message("stream doesn't exist"){
            assert __warp_se_75 = 1;
        }
        
        let (__warp_52_payer) = WS1_INDEX_felt_to_Payer_977769af(LlamaPay.__warp_1_payers, __warp_45_from);
        
        let __warp_53_totalPayerPayment = Uint256(low=0, high=0);
        
        let (__warp_se_76) = warp_block_timestamp();
        
        let (__warp_se_77) = WSM0_Payer_977769af_lastPayerUpdate(__warp_52_payer);
        
        let (__warp_se_78) = WS0_READ_felt(__warp_se_77);
        
        let (__warp_se_79) = warp_uint256(__warp_se_78);
        
        let (__warp_54_payerDelta) = warp_sub256(__warp_se_76, __warp_se_79);
        
            
            let (__warp_se_80) = WSM1_Payer_977769af_totalPaidPerSec(__warp_52_payer);
            
            let (__warp_se_81) = WS0_READ_felt(__warp_se_80);
            
            let (__warp_se_82) = warp_uint256(__warp_se_81);
            
            let (__warp_se_83) = warp_mul_unsafe256(__warp_54_payerDelta, __warp_se_82);
            
            let __warp_53_totalPayerPayment = __warp_se_83;
        
        let (__warp_se_84) = WS2_INDEX_felt_to_Uint256(LlamaPay.__warp_2_balances, __warp_45_from);
        
        let (__warp_55_payerBalance) = WS1_READ_Uint256(__warp_se_84);
        
        let (__warp_se_85) = warp_ge256(__warp_55_payerBalance, __warp_53_totalPayerPayment);
        
        if (__warp_se_85 != 0){
        
            
                
                let (__warp_se_86) = warp_block_timestamp();
                
                let __warp_49_lastUpdate = __warp_se_86;
            
            let (__warp_48_withdrawableAmount, __warp_49_lastUpdate, __warp_50_owed) = LlamaPay.withdrawable_3f053acd_if_part1(__warp_49_lastUpdate, __warp_51_streamId, __warp_48_withdrawableAmount, __warp_47_amountPerSec, __warp_50_owed);
            
            default_dict_finalize(warp_memory_start, warp_memory, 0);
            
            finalize_keccak(keccak_ptr_start, keccak_ptr);
            
            return (__warp_48_withdrawableAmount, __warp_49_lastUpdate, __warp_50_owed);
        }else{
        
            
                
                    
                    let (__warp_se_87) = WSM1_Payer_977769af_totalPaidPerSec(__warp_52_payer);
                    
                    let (__warp_se_88) = WS0_READ_felt(__warp_se_87);
                    
                    let (__warp_se_89) = warp_uint256(__warp_se_88);
                    
                    let (__warp_56_timePaid) = warp_div_unsafe256(__warp_55_payerBalance, __warp_se_89);
                    
                    let (__warp_se_90) = WSM0_Payer_977769af_lastPayerUpdate(__warp_52_payer);
                    
                    let (__warp_se_91) = WS0_READ_felt(__warp_se_90);
                    
                    let (__warp_se_92) = warp_uint256(__warp_se_91);
                    
                    let (__warp_se_93) = warp_add_unsafe256(__warp_se_92, __warp_56_timePaid);
                    
                    let __warp_49_lastUpdate = __warp_se_93;
            
            let (__warp_48_withdrawableAmount, __warp_49_lastUpdate, __warp_50_owed) = LlamaPay.withdrawable_3f053acd_if_part1(__warp_49_lastUpdate, __warp_51_streamId, __warp_48_withdrawableAmount, __warp_47_amountPerSec, __warp_50_owed);
            
            default_dict_finalize(warp_memory_start, warp_memory, 0);
            
            finalize_keccak(keccak_ptr_start, keccak_ptr);
            
            return (__warp_48_withdrawableAmount, __warp_49_lastUpdate, __warp_50_owed);
        }
    }
    }


    @external
    func withdraw_17a566e4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_58_from : felt, __warp_59_to : felt, __warp_60_amountPerSec : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_60_amountPerSec);
        
        warp_external_input_check_address(__warp_59_to);
        
        warp_external_input_check_address(__warp_58_from);
        
        let (__warp_61_lastUpdate, __warp_62_streamId, __warp_63_amountToTransfer) = LlamaPay._withdraw_c2f417c8(__warp_58_from, __warp_59_to, __warp_60_amountPerSec);
        
        let (__warp_se_106) = WS0_INDEX_Uint256_to_Uint256(LlamaPay.__warp_0_streamToStart, __warp_62_streamId);
        
        let (__warp_se_107) = warp_uint256(__warp_61_lastUpdate);
        
        WS_WRITE1(__warp_se_106, __warp_se_107);
        
        let (__warp_se_108) = WS1_INDEX_felt_to_Payer_977769af(LlamaPay.__warp_1_payers, __warp_58_from);
        
        let (__warp_se_109) = WSM0_Payer_977769af_lastPayerUpdate(__warp_se_108);
        
        WS_WRITE0(__warp_se_109, __warp_61_lastUpdate);
        
        let (__warp_se_110) = WS0_READ_felt(LlamaPay.__warp_3_token);
        
        IERC20_warped_interface.transfer_a9059cbb(__warp_se_110, __warp_59_to, __warp_63_amountToTransfer);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func cancelStream_807a379c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_70_to : felt, __warp_71_amountPerSec : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_71_amountPerSec);
        
        warp_external_input_check_address(__warp_70_to);
        
        let (__warp_72_streamId) = LlamaPay._cancelStream_a574052c(__warp_70_to, __warp_71_amountPerSec);
        
        let (__warp_se_120) = get_caller_address();
        
        StreamCancelled_6841f88c.emit(__warp_se_120, __warp_70_to, __warp_71_amountPerSec, __warp_72_streamId);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func pauseStream_5b0c2f2f{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_73_to : felt, __warp_74_amountPerSec : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_74_amountPerSec);
        
        warp_external_input_check_address(__warp_73_to);
        
        let (__warp_75_streamId) = LlamaPay._cancelStream_a574052c(__warp_73_to, __warp_74_amountPerSec);
        
        let (__warp_se_121) = get_caller_address();
        
        StreamPaused_ad944a97.emit(__warp_se_121, __warp_73_to, __warp_74_amountPerSec, __warp_75_streamId);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func modifyStream_c6a64771{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_76_oldTo : felt, __warp_77_oldAmountPerSec : felt, __warp_78_to : felt, __warp_79_amountPerSec : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_79_amountPerSec);
        
        warp_external_input_check_address(__warp_78_to);
        
        warp_external_input_check_int216(__warp_77_oldAmountPerSec);
        
        warp_external_input_check_address(__warp_76_oldTo);
        
        let (__warp_80_oldStreamId) = LlamaPay._cancelStream_a574052c(__warp_76_oldTo, __warp_77_oldAmountPerSec);
        
        let (__warp_81_newStreamId) = LlamaPay._createStream_ac90cfe6(__warp_78_to, __warp_79_amountPerSec);
        
        let (__warp_se_122) = get_caller_address();
        
        StreamModified_0edc6e7e.emit(__warp_se_122, __warp_76_oldTo, __warp_77_oldAmountPerSec, __warp_80_oldStreamId, __warp_78_to, __warp_79_amountPerSec, __warp_81_newStreamId);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func depositAndCreate_5ed1b15d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_83_amountToDeposit : Uint256, __warp_84_to : felt, __warp_85_amountPerSec : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_85_amountPerSec);
        
        warp_external_input_check_address(__warp_84_to);
        
        warp_external_input_check_int256(__warp_83_amountToDeposit);
        
        LlamaPay.deposit_b6b55f25_internal(__warp_83_amountToDeposit);
        
        LlamaPay.createStream_c355f343_internal(__warp_84_to, __warp_85_amountPerSec);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func depositAndCreateWithReason_2087652c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_86_amountToDeposit : Uint256, __warp_87_to : felt, __warp_88_amountPerSec : felt, __warp_89_reason_len : felt, __warp_89_reason : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        extern_input_check0(__warp_89_reason_len, __warp_89_reason);
        
        warp_external_input_check_int216(__warp_88_amountPerSec);
        
        warp_external_input_check_address(__warp_87_to);
        
        warp_external_input_check_int256(__warp_86_amountToDeposit);
        
        local __warp_89_reason_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_89_reason_len, __warp_89_reason);
        
        LlamaPay.deposit_b6b55f25_internal(__warp_86_amountToDeposit);
        
        LlamaPay.createStreamWithReason_8835510c_internal(__warp_87_to, __warp_88_amountPerSec, __warp_89_reason_dstruct);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func withdrawPayerAll_a3f83f6e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
        let (__warp_se_154) = get_caller_address();
        
        let (__warp_94_payer) = WS1_INDEX_felt_to_Payer_977769af(LlamaPay.__warp_1_payers, __warp_se_154);
        
            
            let (__warp_se_155) = warp_block_timestamp();
            
            let (__warp_se_156) = WSM0_Payer_977769af_lastPayerUpdate(__warp_94_payer);
            
            let (__warp_se_157) = WS0_READ_felt(__warp_se_156);
            
            let (__warp_se_158) = warp_uint256(__warp_se_157);
            
            let (__warp_95_delta) = warp_sub_unsafe256(__warp_se_155, __warp_se_158);
            
            let (__warp_se_159) = get_caller_address();
            
            let (__warp_se_160) = WS2_INDEX_felt_to_Uint256(LlamaPay.__warp_2_balances, __warp_se_159);
            
            let (__warp_se_161) = WS1_READ_Uint256(__warp_se_160);
            
            let (__warp_se_162) = WSM1_Payer_977769af_totalPaidPerSec(__warp_94_payer);
            
            let (__warp_se_163) = WS0_READ_felt(__warp_se_162);
            
            let (__warp_se_164) = warp_uint256(__warp_se_163);
            
            let (__warp_se_165) = warp_mul_unsafe256(__warp_95_delta, __warp_se_164);
            
            let (__warp_se_166) = warp_sub_unsafe256(__warp_se_161, __warp_se_165);
            
            LlamaPay.withdrawPayer_bfda0b45_internal(__warp_se_166);
        
        
        
        return ();

    }


    @view
    func getPayerBalance_6e85975e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_96_payerAddress : felt)-> (__warp_97 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_96_payerAddress);
        
        let (__warp_98_payer) = WS1_INDEX_felt_to_Payer_977769af(LlamaPay.__warp_1_payers, __warp_96_payerAddress);
        
        let (__warp_se_167) = WS2_INDEX_felt_to_Uint256(LlamaPay.__warp_2_balances, __warp_96_payerAddress);
        
        let (__warp_99_balance) = WS1_READ_Uint256(__warp_se_167);
        
        let (__warp_se_168) = warp_block_timestamp();
        
        let (__warp_se_169) = WSM0_Payer_977769af_lastPayerUpdate(__warp_98_payer);
        
        let (__warp_se_170) = WS0_READ_felt(__warp_se_169);
        
        let (__warp_se_171) = warp_uint256(__warp_se_170);
        
        let (__warp_100_delta) = warp_sub256(__warp_se_168, __warp_se_171);
        
        let (__warp_se_172) = WSM1_Payer_977769af_totalPaidPerSec(__warp_98_payer);
        
        let (__warp_se_173) = WS0_READ_felt(__warp_se_172);
        
        let (__warp_se_174) = warp_uint256(__warp_se_173);
        
        let (__warp_se_175) = warp_mul_signed256(__warp_100_delta, __warp_se_174);
        
        let (__warp_se_176) = warp_sub_signed256(__warp_99_balance, __warp_se_175);
        
        let (__warp_se_177) = WS1_READ_Uint256(LlamaPay.__warp_4_DECIMALS_DIVISOR);
        
        let (__warp_se_178) = warp_div_signed256(__warp_se_176, __warp_se_177);
        
        
        
        return (__warp_se_178,);

    }


    @view
    func streamToStart_6bc16095{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_101__i0 : Uint256)-> (__warp_102 : Uint256){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_101__i0);
        
        let (__warp_se_179) = WS0_INDEX_Uint256_to_Uint256(LlamaPay.__warp_0_streamToStart, __warp_101__i0);
        
        let (__warp_se_180) = WS1_READ_Uint256(__warp_se_179);
        
        
        
        return (__warp_se_180,);

    }


    @view
    func payers_4a714c24{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_103__i0 : felt)-> (__warp_104 : felt, __warp_105 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_103__i0);
        
        let (__warp_106__temp0) = WS1_INDEX_felt_to_Payer_977769af(LlamaPay.__warp_1_payers, __warp_103__i0);
        
        let (__warp_se_181) = WSM0_Payer_977769af_lastPayerUpdate(__warp_106__temp0);
        
        let (__warp_104) = WS0_READ_felt(__warp_se_181);
        
        let (__warp_se_182) = WSM1_Payer_977769af_totalPaidPerSec(__warp_106__temp0);
        
        let (__warp_105) = WS0_READ_felt(__warp_se_182);
        
        
        
        return (__warp_104, __warp_105);

    }


    @view
    func balances_27e235e3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_107__i0 : felt)-> (__warp_108 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_107__i0);
        
        let (__warp_se_183) = WS2_INDEX_felt_to_Uint256(LlamaPay.__warp_2_balances, __warp_107__i0);
        
        let (__warp_se_184) = WS1_READ_Uint256(__warp_se_183);
        
        
        
        return (__warp_se_184,);

    }


    @view
    func token_fc0c546a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_109 : felt){
    alloc_locals;


        
        let (__warp_se_185) = WS0_READ_felt(LlamaPay.__warp_3_token);
        
        
        
        return (__warp_se_185,);

    }


    @view
    func DECIMALS_DIVISOR_2b4146f8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_110 : Uint256){
    alloc_locals;


        
        let (__warp_se_186) = WS1_READ_Uint256(LlamaPay.__warp_4_DECIMALS_DIVISOR);
        
        
        
        return (__warp_se_186,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(){
    alloc_locals;
    WARP_USED_STORAGE.write(6);
    WARP_NAMEGEN.write(3);


        
        LlamaPay.__warp_constructor_0();
        
        
        
        return ();

    }


    @view
    func getStreamId_a05860e0{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_14_from : felt, __warp_15_to : felt, __warp_16_amountPerSec : felt)-> (__warp_17 : Uint256){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_16_amountPerSec);
        
        warp_external_input_check_address(__warp_15_to);
        
        warp_external_input_check_address(__warp_14_from);
        
        let (__warp_pse_3) = LlamaPay.getStreamId_a05860e0_internal(__warp_14_from, __warp_15_to, __warp_16_amountPerSec);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_pse_3,);
    }
    }


    @external
    func createStream_c355f343{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_26_to : felt, __warp_27_amountPerSec : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int216(__warp_27_amountPerSec);
        
        warp_external_input_check_address(__warp_26_to);
        
        LlamaPay.createStream_c355f343_internal(__warp_26_to, __warp_27_amountPerSec);
        
        let __warp_uv2 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func createStreamWithReason_8835510c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_29_to : felt, __warp_30_amountPerSec : felt, __warp_31_reason_len : felt, __warp_31_reason : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        extern_input_check0(__warp_31_reason_len, __warp_31_reason);
        
        warp_external_input_check_int216(__warp_30_amountPerSec);
        
        warp_external_input_check_address(__warp_29_to);
        
        local __warp_31_reason_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_31_reason_len, __warp_31_reason);
        
        LlamaPay.createStreamWithReason_8835510c_internal(__warp_29_to, __warp_30_amountPerSec, __warp_31_reason_dstruct);
        
        let __warp_uv3 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func deposit_b6b55f25{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_82_amount : Uint256)-> (){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_82_amount);
        
        LlamaPay.deposit_b6b55f25_internal(__warp_82_amount);
        
        let __warp_uv4 = ();
        
        
        
        return ();

    }


    @external
    func withdrawPayer_bfda0b45{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_90_amount : Uint256)-> (){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_90_amount);
        
        LlamaPay.withdrawPayer_bfda0b45_internal(__warp_90_amount);
        
        let __warp_uv5 = ();
        
        
        
        return ();

    }

@storage_var
func WARP_STORAGE(index: felt) -> (val: felt){
}
@storage_var
func WARP_USED_STORAGE() -> (val: felt){
}
@storage_var
func WARP_NAMEGEN() -> (name: felt){
}
func readId{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) -> (val: felt){
    alloc_locals;
    let (id) = WARP_STORAGE.read(loc);
    if (id == 0){
        let (id) = WARP_NAMEGEN.read();
        WARP_NAMEGEN.write(id + 1);
        WARP_STORAGE.write(loc, id + 1);
        return (id + 1,);
    }else{
        return (id,);
    }
}


// Contract Def IERC20@interface


@contract_interface
namespace IERC20_warped_interface{
func totalSupply_18160ddd()-> (__warp_0 : Uint256){
}
func balanceOf_70a08231(account : felt)-> (__warp_1 : Uint256){
}
//  @dev Moves `amount` tokens from the caller's account to `to`.
// Returns a boolean value indicating whether the operation succeeded.
// Emits a {
}
//  @dev Returns the remaining number of tokens that `spender` will be
// allowed to spend on behalf of `owner` through {
}
//  @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
// Returns a boolean value indicating whether the operation succeeded.
// IMPORTANT: Beware that changing an allowance with this method brings the risk
// that someone may use both the old and the new allowance by unfortunate
// transaction ordering. One possible solution to mitigate this race
// condition is to first reduce the spender's allowance to 0 and set the
// desired value afterwards:
// https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
// Emits an {
}
//  @dev Moves `amount` tokens from `from` to `to` using the
// allowance mechanism. `amount` is then deducted from the caller's
// allowance.
// Returns a boolean value indicating whether the operation succeeded.
// Emits a {
}
}


// Contract Def ERC20@interface


@contract_interface
namespace ERC20_warped_interface{
func name_06fdde03()-> (__warp_7_len : felt, __warp_7 : felt*){
}
func symbol_95d89b41()-> (__warp_8_len : felt, __warp_8 : felt*){
}
//  @dev Returns the number of decimals used to get its user representation.
// For example, if `decimals` equals `2`, a balance of `505` tokens should
// be displayed to a user as `5.05` (`505 / 10 ** 2`).
// Tokens usually opt for a value of 18, imitating the relationship between
// Ether and Wei. This is the value {
}
//  @dev See {
}
//  @dev See {
}
//  @dev See {
}
//  @dev See {
}
//  @dev See {
}
//  @dev See {
}
//  @dev Atomically increases the allowance granted to `spender` by the caller.
// This is an alternative to {
}
//  @dev Atomically decreases the allowance granted to `spender` by the caller.
// This is an alternative to {
}
}


// Contract Def Factory@interface


@contract_interface
namespace Factory_warped_interface{
func parameter_ad4d4e29()-> (__warp_0 : felt){
}
}


// Contract Def IERC20WithDecimals@interface


@contract_interface
namespace IERC20WithDecimals_warped_interface{
func decimals_313ce567()-> (__warp_0 : felt){
}
}