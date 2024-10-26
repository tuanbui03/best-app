package com.best.springbest.controller;

import com.best.springbest.dto.VoucherDto;
import com.best.springbest.model.Voucher;
import com.best.springbest.service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class VoucherController {
    @Autowired
    VoucherService voucherService;
    @RequestMapping(value = "api/best_app/voucher/all", method = RequestMethod.GET)
    public List<Voucher> getAllVouchers(){
        return voucherService.getAllVoucher();
    }
    @RequestMapping(value = "api/best_app/voucher/detail", method = RequestMethod.GET)
    public Voucher getVoucherByID(@RequestParam int id){
        return voucherService.getVoucherByID(id);
    }

    @RequestMapping(value = "api/best_app/voucher/byShop", method = RequestMethod.GET)
    public List<Voucher> getVoucherByShopID(@RequestParam int shopID){
        return voucherService.getVoucherByShopID(shopID);
    }

    @RequestMapping(value = "api/best_app/voucher/create", method = RequestMethod.POST)
    public boolean addVoucher(@RequestBody VoucherDto voucher){
        return voucherService.addVoucher(voucher);
    }
    @RequestMapping(value = "api/best_app/voucher/update", method = RequestMethod.PUT)
    public boolean updateVoucher(@RequestBody VoucherDto voucher){
        return voucherService.updateVoucher(voucher);
    }
    @RequestMapping(value = "api/best_app/voucher/delete", method = RequestMethod.DELETE)
    public boolean removeVoucher(@RequestParam int id){
        return voucherService.removeVoucher(id);
    }
}
