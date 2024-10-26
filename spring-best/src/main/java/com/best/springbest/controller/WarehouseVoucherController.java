package com.best.springbest.controller;

import com.best.springbest.dto.WarehouseVoucherDto;
import com.best.springbest.model.WarehouseVoucher;
import com.best.springbest.service.WarehouseVoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class WarehouseVoucherController {
    @Autowired
    WarehouseVoucherService warehouseVoucherService;
    @RequestMapping(value = "api/best_app/warehouse_voucher/all", method = RequestMethod.GET)
    public List<WarehouseVoucher> getAllWarehouseVouchers(){
        return warehouseVoucherService.getAllWarehouseVoucher();
    }
    @RequestMapping(value = "api/best_app/warehouse_voucher/detail", method = RequestMethod.GET)
    public Object getWarehouseVoucherByID(@RequestParam int id){
        return warehouseVoucherService.getWarehouseVoucherByID(id);
    }
    @RequestMapping(value = "api/best_app/warehouse_voucher/byUser", method = RequestMethod.GET)
    public List<WarehouseVoucher> getWarehouseVoucherByUserID(@RequestParam int userID){
        return warehouseVoucherService.getWarehouseVoucherByUserId(userID);
    }
    @RequestMapping(value = "api/best_app/warehouse_voucher/byUser_Product", method = RequestMethod.GET)
    public List<WarehouseVoucher> getWarehouseVoucherByUserIdAndProductID(@RequestParam int userID, @RequestParam int productID){
        return warehouseVoucherService.getWarehouseVoucherByUserIdAndProductID(userID, productID);
    }
    @RequestMapping(value = "api/best_app/warehouse_voucher/create", method = RequestMethod.POST)
    public boolean addWarehouseVoucher(@RequestBody WarehouseVoucherDto ob) {
        return warehouseVoucherService.addWarehouseVoucher(ob);
    }
    @RequestMapping(value = "api/best_app/warehouse_voucher/update", method = RequestMethod.PUT)
    public boolean updateWarehouseVoucher(@RequestBody WarehouseVoucherDto ob) {
        return warehouseVoucherService.updateWarehouseVoucher(ob);
    }
    @RequestMapping(value = "api/best_app/warehouse_voucher/delete", method = RequestMethod.DELETE)
    public boolean removeWarehouseVoucher(@RequestParam int id){
        return warehouseVoucherService.removeWarehouseVoucher(id);
    }
}
