package com.best.springbest.service;

import com.best.springbest.dto.WarehouseVoucherDto;
import com.best.springbest.model.Voucher;
import com.best.springbest.model.WarehouseVoucher;
import com.best.springbest.model.User;
import com.best.springbest.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WarehouseVoucherService {
    @Autowired
    WarehouseVoucherRepository obRepository;
    @Autowired
    VoucherRepository voucherRepository;
    @Autowired
    UserRepository uRepository;
    public List<WarehouseVoucher> getAllWarehouseVoucher(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public WarehouseVoucher getWarehouseVoucherByID(int id){
        try{
            return obRepository.findWarehouseVoucherByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<WarehouseVoucher> getWarehouseVoucherByUserId(int userID){
        try{
            return obRepository.findWarehouseVoucherByUserId(userID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<WarehouseVoucher> getWarehouseVoucherByUserIdAndProductID(int userID, int productID){
        try{
            return obRepository.findWarehouseVoucherByUserIdAndProductID(userID, productID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public boolean addWarehouseVoucher(WarehouseVoucherDto ob){
        try{
            Voucher voucher = voucherRepository.findVouchersByID(ob.getVoucher_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new WarehouseVoucher(0,user,voucher));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateWarehouseVoucher(WarehouseVoucherDto ob){
        try{
            Voucher voucher = voucherRepository.findVouchersByID(ob.getVoucher_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new WarehouseVoucher(0,user,voucher));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeWarehouseVoucher(int id){
        try{
            WarehouseVoucher ob = obRepository.findWarehouseVoucherByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
