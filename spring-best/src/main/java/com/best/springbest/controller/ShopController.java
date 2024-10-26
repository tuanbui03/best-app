package com.best.springbest.controller;

import com.best.springbest.model.Shop;
import com.best.springbest.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class ShopController {
    @Autowired
    ShopService shopService;
    @RequestMapping(value = "api/best_app/shop/all", method = RequestMethod.GET)
    public List<Shop> getAllShops(){
        return shopService.getAllShop();
    }
    @RequestMapping(value = "api/best_app/shop/detail", method = RequestMethod.GET)
    public Object getShopByID(@RequestParam int id){
        return shopService.getShopByID(id);
    }
    @RequestMapping(value = "api/best_app/shop/search", method = RequestMethod.GET)
    public Object getShopBySearchName(@RequestParam String name){
        return shopService.getShopBySearchName(name);
    }

    @RequestMapping(value = "api/best_app/shop/create", method = RequestMethod.POST)
    public boolean addShop(@RequestBody Shop Shop) {
        return shopService.addShop(Shop);
    }
    @RequestMapping(value = "api/best_app/shop/update", method = RequestMethod.PUT)
    public boolean updateShop(@RequestBody Shop Shop) {
        return shopService.updateShop(Shop);
    }
    @RequestMapping(value = "api/best_app/shop/delete", method = RequestMethod.DELETE)
    public boolean removeShop(@RequestParam int id){
        return shopService.removeShop(id);
    }
}
