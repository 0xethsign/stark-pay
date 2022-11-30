%lang starknet


from starkware.cairo.common.dict import dict_read, dict_write
from starkware.cairo.common.uint256 import uint256_sub, uint256_lt, Uint256, uint256_eq, uint256_add
from warplib.memory import wm_dyn_array_length, wm_new
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.int_conversions import warp_uint256
from starkware.cairo.common.alloc import alloc
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.dict_access import DictAccess
from starkware.starknet.common.syscalls import get_caller_address
from warplib.maths.add import warp_add256
from warplib.maths.ge import warp_ge256
from warplib.maths.sub_unsafe import warp_sub_unsafe256
from warplib.maths.neq import warp_neq, warp_neq256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func wm_to_storage0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(storage_name: felt, mem_loc : felt, length: Uint256) -> (){
    alloc_locals;
    if (length.low == 0 and length.high == 0){
        return ();
    }
    let (index) = uint256_sub(length, Uint256(1,0));
    let (storage_loc) = WARP_DARRAY0_felt.read(storage_name, index);
    let mem_loc = mem_loc - 1;
    if (storage_loc == 0){
        let (storage_loc) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(storage_loc + 1);
        WARP_DARRAY0_felt.write(storage_name, index, storage_loc);
    let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage0_elem(storage_name, mem_loc, index);
    }else{
    let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage0_elem(storage_name, mem_loc, index);
    }
}
func wm_to_storage0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt, mem_loc : felt) -> (loc : felt){
    alloc_locals;
    let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
    let (mem_length) = wm_dyn_array_length(mem_loc);
    WARP_DARRAY0_felt_LENGTH.write(loc, mem_length);
    let (narrowedLength) = narrow_safe(mem_length);
    wm_to_storage0_elem(loc, mem_loc + 2 + 1 * narrowedLength, mem_length);
    let (lesser) = uint256_lt(mem_length, length);
    if (lesser == 1){
       WS0_DYNAMIC_ARRAY_DELETE_elem(loc, mem_length, length);
       return (loc,);
    }else{
       return (loc,);
    }
}

func WS0_DYNAMIC_ARRAY_DELETE_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt, index : Uint256, length : Uint256){
     alloc_locals;
     let (stop) = uint256_eq(index, length);
     if (stop == 1){
        return ();
     }
     let (elem_loc) = WARP_DARRAY0_felt.read(loc, index);
    WS1_DELETE(elem_loc);
     let (next_index, _) = uint256_add(index, Uint256(0x1, 0x0));
     return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, next_index, length);
}
func WS0_DYNAMIC_ARRAY_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt){
   alloc_locals;
   let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
   WARP_DARRAY0_felt_LENGTH.write(loc, Uint256(0x0, 0x0));
   return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, Uint256(0x0, 0x0), length);
}

func WS1_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    return ();
}

func WS0_READ_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = readId(loc);
    return (read0,);
}

func WS1_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}

func WS2_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func ws_dynamic_array_to_calldata0_write{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(
   loc : felt,
   index : felt,
   len : felt,
   ptr : felt*) -> (ptr : felt*){
   alloc_locals;
   if (len == index){
       return (ptr,);
   }
   let (index_uint256) = warp_uint256(index);
   let (elem_loc) = WARP_DARRAY0_felt.read(loc, index_uint256);
   let (elem) = WS1_READ_felt(elem_loc);
   assert ptr[index] = elem;
   return ws_dynamic_array_to_calldata0_write(loc, index + 1, len, ptr);
}
func ws_dynamic_array_to_calldata0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt) -> (dyn_array_struct : cd_dynarray_felt){
   alloc_locals;
   let (len_uint256) = WARP_DARRAY0_felt_LENGTH.read(loc);
   let len = len_uint256.low + len_uint256.high*128;
   let (ptr : felt*) = alloc();
   let (ptr : felt*) = ws_dynamic_array_to_calldata0_write(loc, 0, len, ptr);
   let dyn_array_struct = cd_dynarray_felt(len, ptr);
   return (dyn_array_struct,);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
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

@storage_var
func WARP_DARRAY0_felt(name: felt, index: Uint256) -> (resLoc : felt){
}
@storage_var
func WARP_DARRAY0_felt_LENGTH(name: felt) -> (index: Uint256){
}

@storage_var
func WARP_MAPPING0(name: felt, index: felt) -> (resLoc : felt){
}
func WS0_INDEX_felt_to_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
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
func WS1_INDEX_felt_to_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING1.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING1.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}


// Contract Def ERC20

//  @dev Implementation of the {IERC20} interface.
// This implementation is agnostic to the way tokens are created. This means
// that a supply mechanism has to be added in a derived contract using {_mint}.
// For a generic mechanism see {ERC20PresetMinterPauser}.
// TIP: For a detailed writeup see our guide
// https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
// to implement supply mechanisms].
// We have followed general OpenZeppelin Contracts guidelines: functions revert
// instead returning `false` on failure. This behavior is nonetheless
// conventional and does not conflict with the expectations of ERC20
// applications.
// Additionally, an {Approval} event is emitted on calls to {transferFrom}.
// This allows applications to reconstruct the allowance for all accounts just
// by listening to said events. Other implementations of the EIP may not emit
// these events, as it isn't required by the specification.
// Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
// functions have been added to mitigate the well-known issues around setting
// allowances. See {IERC20-approve}.

//  @dev Emitted when the allowance of a `spender` for an `owner` is set by
// a call to {approve}. `value` is the new allowance.
@event
func Approval_8c5be1e5(owner : felt, spender : felt, value : Uint256){
}

//  @dev Emitted when `value` tokens are moved from one account (`from`) to
// another (`to`).
// Note that `value` may be zero.
@event
func Transfer_ddf252ad(__warp_7_from : felt, to : felt, value : Uint256){
}

namespace ERC20{

    // Dynamic variables - Arrays and Maps

    const __warp_0__balances = 1;

    const __warp_1__allowances = 2;

    const __warp_3__name = 3;

    const __warp_4__symbol = 4;

    // Static variables

    const __warp_2__totalSupply = 2;

    //  @dev Sets the values for {name} and {symbol}.
    // The default value of {decimals} is 18. To select a different value for
    // {decimals} you should overload it.
    // All two of these values are immutable: they can only be set once during
    // construction.
    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(__warp_5_name_ : felt, __warp_6_symbol_ : felt)-> (){
    alloc_locals;


        
        wm_to_storage0(__warp_3__name, __warp_5_name_);
        
        wm_to_storage0(__warp_4__symbol, __warp_6_symbol_);
        
        
        
        return ();

    }

    //  @dev See {IERC20-allowance}.
    func allowance_dd62ed3e_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_17_owner : felt, __warp_18_spender : felt)-> (__warp_19 : Uint256){
    alloc_locals;


        
        let (__warp_se_5) = WS1_INDEX_felt_to_warp_id(__warp_1__allowances, __warp_17_owner);
        
        let (__warp_se_6) = WS0_READ_warp_id(__warp_se_5);
        
        let (__warp_se_7) = WS0_INDEX_felt_to_Uint256(__warp_se_6, __warp_18_spender);
        
        let (__warp_se_8) = WS2_READ_Uint256(__warp_se_7);
        
        
        
        return (__warp_se_8,);

    }

    //  @dev Moves `amount` of tokens from `sender` to `recipient`.
    // This internal function is equivalent to {transfer}, and can be used to
    // e.g. implement automatic token fees, slashing mechanisms, etc.
    // Emits a {Transfer} event.
    // Requirements:
    // - `from` cannot be the zero address.
    // - `to` cannot be the zero address.
    // - `from` must have a balance of at least `amount`.
    func _transfer_30e0789e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_38_from : felt, __warp_39_to : felt, __warp_40_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_19) = warp_neq(__warp_38_from, 0);
        
        with_attr error_message("ERC20: transfer from the zero address"){
            assert __warp_se_19 = 1;
        }
        
        let (__warp_se_20) = warp_neq(__warp_39_to, 0);
        
        with_attr error_message("ERC20: transfer to the zero address"){
            assert __warp_se_20 = 1;
        }
        
        _beforeTokenTransfer_cad3be83(__warp_38_from, __warp_39_to, __warp_40_amount);
        
        let (__warp_se_21) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_38_from);
        
        let (__warp_41_fromBalance) = WS2_READ_Uint256(__warp_se_21);
        
        let (__warp_se_22) = warp_ge256(__warp_41_fromBalance, __warp_40_amount);
        
        with_attr error_message("ERC20: transfer amount exceeds balance"){
            assert __warp_se_22 = 1;
        }
        
            
            let (__warp_se_23) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_38_from);
            
            let (__warp_se_24) = warp_sub_unsafe256(__warp_41_fromBalance, __warp_40_amount);
            
            WS_WRITE0(__warp_se_23, __warp_se_24);
        
        let __warp_cs_0 = __warp_39_to;
        
        let (__warp_se_25) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_cs_0);
        
        let (__warp_se_26) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_cs_0);
        
        let (__warp_se_27) = WS2_READ_Uint256(__warp_se_26);
        
        let (__warp_se_28) = warp_add256(__warp_se_27, __warp_40_amount);
        
        WS_WRITE0(__warp_se_25, __warp_se_28);
        
        Transfer_ddf252ad.emit(__warp_38_from, __warp_39_to, __warp_40_amount);
        
        _afterTokenTransfer_8f811a1c(__warp_38_from, __warp_39_to, __warp_40_amount);
        
        
        
        return ();

    }

    //  @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
    // This internal function is equivalent to `approve`, and can be used to
    // e.g. set automatic allowances for certain subsystems, etc.
    // Emits an {Approval} event.
    // Requirements:
    // - `owner` cannot be the zero address.
    // - `spender` cannot be the zero address.
    func _approve_104e81ff{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_47_owner : felt, __warp_48_spender : felt, __warp_49_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_29) = warp_neq(__warp_47_owner, 0);
        
        with_attr error_message("ERC20: approve from the zero address"){
            assert __warp_se_29 = 1;
        }
        
        let (__warp_se_30) = warp_neq(__warp_48_spender, 0);
        
        with_attr error_message("ERC20: approve to the zero address"){
            assert __warp_se_30 = 1;
        }
        
        let (__warp_se_31) = WS1_INDEX_felt_to_warp_id(__warp_1__allowances, __warp_47_owner);
        
        let (__warp_se_32) = WS0_READ_warp_id(__warp_se_31);
        
        let (__warp_se_33) = WS0_INDEX_felt_to_Uint256(__warp_se_32, __warp_48_spender);
        
        WS_WRITE0(__warp_se_33, __warp_49_amount);
        
        Approval_8c5be1e5.emit(__warp_47_owner, __warp_48_spender, __warp_49_amount);
        
        
        
        return ();

    }

    //  @dev Spend `amount` form the allowance of `owner` toward `spender`.
    // Does not update the allowance amount in case of infinite allowance.
    // Revert if not enough allowance is available.
    // Might emit an {Approval} event.
    func _spendAllowance_1532335e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_50_owner : felt, __warp_51_spender : felt, __warp_52_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_53_currentAllowance) = allowance_dd62ed3e_internal(__warp_50_owner, __warp_51_spender);
        
        let (__warp_se_34) = warp_neq256(__warp_53_currentAllowance, Uint256(low=340282366920938463463374607431768211455, high=340282366920938463463374607431768211455));
        
        if (__warp_se_34 != 0){
        
            
                
                let (__warp_se_35) = warp_ge256(__warp_53_currentAllowance, __warp_52_amount);
                
                with_attr error_message("ERC20: insufficient allowance"){
                    assert __warp_se_35 = 1;
                }
                
                    
                    let (__warp_se_36) = warp_sub_unsafe256(__warp_53_currentAllowance, __warp_52_amount);
                    
                    _approve_104e81ff(__warp_50_owner, __warp_51_spender, __warp_se_36);
            
            _spendAllowance_1532335e_if_part1();
            
            let __warp_uv0 = ();
            
            
            
            return ();
        }else{
        
            
            _spendAllowance_1532335e_if_part1();
            
            let __warp_uv1 = ();
            
            
            
            return ();
        }

    }


    func _spendAllowance_1532335e_if_part1()-> (){
    alloc_locals;


        
        
        
        return ();

    }

    //  @dev Hook that is called before any transfer of tokens. This includes
    // minting and burning.
    // Calling conditions:
    // - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
    // will be transferred to `to`.
    // - when `from` is zero, `amount` tokens will be minted for `to`.
    // - when `to` is zero, `amount` of ``from``'s tokens will be burned.
    // - `from` and `to` are never both zero.
    // To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
    func _beforeTokenTransfer_cad3be83(__warp_54_from : felt, to : felt, amount : Uint256)-> (){
    alloc_locals;


        
        
        
        return ();

    }

    //  @dev Hook that is called after any transfer of tokens. This includes
    // minting and burning.
    // Calling conditions:
    // - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
    // has been transferred to `to`.
    // - when `from` is zero, `amount` tokens have been minted for `to`.
    // - when `to` is zero, `amount` of ``from``'s tokens have been burned.
    // - `from` and `to` are never both zero.
    // To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
    func _afterTokenTransfer_8f811a1c(__warp_55_from : felt, to : felt, amount : Uint256)-> (){
    alloc_locals;


        
        
        
        return ();

    }


    func _msgSender_119df25f{syscall_ptr : felt*}()-> (__warp_56 : felt){
    alloc_locals;


        
        let (__warp_se_37) = get_caller_address();
        
        
        
        return (__warp_se_37,);

    }

}

    //  @dev Returns the name of the token.
    @view
    func name_06fdde03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_7_len : felt, __warp_7 : felt*){
    alloc_locals;


        
        let (__warp_se_0) = ws_dynamic_array_to_calldata0(ERC20.__warp_3__name);
        
        
        
        return (__warp_se_0.len, __warp_se_0.ptr,);

    }

    //  @dev Returns the symbol of the token, usually a shorter version of the
    // name.
    @view
    func symbol_95d89b41{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_8_len : felt, __warp_8 : felt*){
    alloc_locals;


        
        let (__warp_se_1) = ws_dynamic_array_to_calldata0(ERC20.__warp_4__symbol);
        
        
        
        return (__warp_se_1.len, __warp_se_1.ptr,);

    }

    //  @dev Returns the number of decimals used to get its user representation.
    // For example, if `decimals` equals `2`, a balance of `505` tokens should
    // be displayed to a user as `5.05` (`505 / 10 ** 2`).
    // Tokens usually opt for a value of 18, imitating the relationship between
    // Ether and Wei. This is the value {ERC20} uses, unless this function is
    // overridden;
    // NOTE: This information is only used for _display_ purposes: it in
    // no way affects any of the arithmetic of the contract, including
    // {IERC20-balanceOf} and {IERC20-transfer}.
    @view
    func decimals_313ce567{syscall_ptr : felt*, range_check_ptr : felt}()-> (__warp_9 : felt){
    alloc_locals;


        
        
        
        return (18,);

    }

    //  @dev See {IERC20-totalSupply}.
    @view
    func totalSupply_18160ddd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_10 : Uint256){
    alloc_locals;


        
        let (__warp_se_2) = WS2_READ_Uint256(ERC20.__warp_2__totalSupply);
        
        
        
        return (__warp_se_2,);

    }

    //  @dev See {IERC20-balanceOf}.
    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_11_account : felt)-> (__warp_12 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_11_account);
        
        let (__warp_se_3) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_0__balances, __warp_11_account);
        
        let (__warp_se_4) = WS2_READ_Uint256(__warp_se_3);
        
        
        
        return (__warp_se_4,);

    }

    //  @dev See {IERC20-transfer}.
    // Requirements:
    // - `to` cannot be the zero address.
    // - the caller must have a balance of at least `amount`.
    @external
    func transfer_a9059cbb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_13_to : felt, __warp_14_amount : Uint256)-> (__warp_15 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_14_amount);
        
        warp_external_input_check_address(__warp_13_to);
        
        let (__warp_16_owner) = get_caller_address();
        
        ERC20._transfer_30e0789e(__warp_16_owner, __warp_13_to, __warp_14_amount);
        
        
        
        return (1,);

    }

    //  @dev See {IERC20-approve}.
    // NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
    // `transferFrom`. This is semantically equivalent to an infinite approval.
    // Requirements:
    // - `spender` cannot be the zero address.
    @external
    func approve_095ea7b3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_20_spender : felt, __warp_21_amount : Uint256)-> (__warp_22 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_21_amount);
        
        warp_external_input_check_address(__warp_20_spender);
        
        let (__warp_23_owner) = ERC20._msgSender_119df25f();
        
        ERC20._approve_104e81ff(__warp_23_owner, __warp_20_spender, __warp_21_amount);
        
        
        
        return (1,);

    }

    //  @dev See {IERC20-transferFrom}.
    // Emits an {Approval} event indicating the updated allowance. This is not
    // required by the EIP. See the note at the beginning of {ERC20}.
    // NOTE: Does not update the allowance if the current allowance
    // is the maximum `uint256`.
    // Requirements:
    // - `from` and `to` cannot be the zero address.
    // - `from` must have a balance of at least `amount`.
    // - the caller must have allowance for ``from``'s tokens of at least
    // `amount`.
    @external
    func transferFrom_23b872dd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_24_from : felt, __warp_25_to : felt, __warp_26_amount : Uint256)-> (__warp_27 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_26_amount);
        
        warp_external_input_check_address(__warp_25_to);
        
        warp_external_input_check_address(__warp_24_from);
        
        let (__warp_28_spender) = ERC20._msgSender_119df25f();
        
        ERC20._spendAllowance_1532335e(__warp_24_from, __warp_28_spender, __warp_26_amount);
        
        ERC20._transfer_30e0789e(__warp_24_from, __warp_25_to, __warp_26_amount);
        
        
        
        return (1,);

    }

    //  @dev Atomically increases the allowance granted to `spender` by the caller.
    // This is an alternative to {approve} that can be used as a mitigation for
    // problems described in {IERC20-approve}.
    // Emits an {Approval} event indicating the updated allowance.
    // Requirements:
    // - `spender` cannot be the zero address.
    @external
    func increaseAllowance_39509351{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_29_spender : felt, __warp_30_addedValue : Uint256)-> (__warp_31 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_30_addedValue);
        
        warp_external_input_check_address(__warp_29_spender);
        
        let (__warp_32_owner) = ERC20._msgSender_119df25f();
        
        let (__warp_se_9) = WS1_INDEX_felt_to_warp_id(ERC20.__warp_1__allowances, __warp_32_owner);
        
        let (__warp_se_10) = WS0_READ_warp_id(__warp_se_9);
        
        let (__warp_se_11) = WS0_INDEX_felt_to_Uint256(__warp_se_10, __warp_29_spender);
        
        let (__warp_se_12) = WS2_READ_Uint256(__warp_se_11);
        
        let (__warp_se_13) = warp_add256(__warp_se_12, __warp_30_addedValue);
        
        ERC20._approve_104e81ff(__warp_32_owner, __warp_29_spender, __warp_se_13);
        
        
        
        return (1,);

    }

    //  @dev Atomically decreases the allowance granted to `spender` by the caller.
    // This is an alternative to {approve} that can be used as a mitigation for
    // problems described in {IERC20-approve}.
    // Emits an {Approval} event indicating the updated allowance.
    // Requirements:
    // - `spender` cannot be the zero address.
    // - `spender` must have allowance for the caller of at least
    // `subtractedValue`.
    @external
    func decreaseAllowance_a457c2d7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_33_spender : felt, __warp_34_subtractedValue : Uint256)-> (__warp_35 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_34_subtractedValue);
        
        warp_external_input_check_address(__warp_33_spender);
        
        let (__warp_36_owner) = ERC20._msgSender_119df25f();
        
        let (__warp_se_14) = WS1_INDEX_felt_to_warp_id(ERC20.__warp_1__allowances, __warp_36_owner);
        
        let (__warp_se_15) = WS0_READ_warp_id(__warp_se_14);
        
        let (__warp_se_16) = WS0_INDEX_felt_to_Uint256(__warp_se_15, __warp_33_spender);
        
        let (__warp_37_currentAllowance) = WS2_READ_Uint256(__warp_se_16);
        
        let (__warp_se_17) = warp_ge256(__warp_37_currentAllowance, __warp_34_subtractedValue);
        
        with_attr error_message("ERC20: decreased allowance below zero"){
            assert __warp_se_17 = 1;
        }
        
            
            let (__warp_se_18) = warp_sub_unsafe256(__warp_37_currentAllowance, __warp_34_subtractedValue);
            
            ERC20._approve_104e81ff(__warp_36_owner, __warp_33_spender, __warp_se_18);
        
        
        
        return (1,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_5_name__len : felt, __warp_5_name_ : felt*, __warp_6_symbol__len : felt, __warp_6_symbol_ : felt*){
    alloc_locals;
    WARP_USED_STORAGE.write(6);
    WARP_NAMEGEN.write(4);
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        extern_input_check0(__warp_6_symbol__len, __warp_6_symbol_);
        
        extern_input_check0(__warp_5_name__len, __warp_5_name_);
        
        local __warp_6_symbol__dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_6_symbol__len, __warp_6_symbol_);
        
        let (__warp_6_symbol__mem) = cd_to_memory0(__warp_6_symbol__dstruct);
        
        local __warp_5_name__dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_5_name__len, __warp_5_name_);
        
        let (__warp_5_name__mem) = cd_to_memory0(__warp_5_name__dstruct);
        
        ERC20.__warp_constructor_0(__warp_5_name__mem, __warp_6_symbol__mem);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return ();
    }
    }

    //  @dev See {IERC20-allowance}.
    @view
    func allowance_dd62ed3e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_17_owner : felt, __warp_18_spender : felt)-> (__warp_19 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_18_spender);
        
        warp_external_input_check_address(__warp_17_owner);
        
        let (__warp_pse_0) = ERC20.allowance_dd62ed3e_internal(__warp_17_owner, __warp_18_spender);
        
        
        
        return (__warp_pse_0,);

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