package com.best.springbest.controller;

import com.best.springbest.dto.WishlistDto;
import com.best.springbest.model.Wishlist;
import com.best.springbest.service.WishlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class WishlistController {
    @Autowired
    WishlistService wishlistService;
    @RequestMapping(value = "api/best_app/wishlist/all", method = RequestMethod.GET)
    public List<Wishlist> getAllWishlists(){
        return wishlistService.getAllWishlist();
    }
    @RequestMapping(value = "api/best_app/wishlist/detail", method = RequestMethod.GET)
    public Wishlist getWishlistByID(@RequestParam int id){
        return wishlistService.getWishlistByID(id);
    }
    @RequestMapping(value = "api/best_app/wishlist/u_p", method = RequestMethod.GET)
    public Wishlist getWishlistByUserIDAndProductID(@RequestParam int userID,@RequestParam int productID){
        return wishlistService.getWishlistByUserIDAndProductID(userID,productID);}
    @RequestMapping(value = "api/best_app/wishlist/userID", method = RequestMethod.GET)
    public List<Wishlist> getWishlistByUserID(@RequestParam int id){
        return wishlistService.getWishlistByUserID(id);
    }

    @RequestMapping(value = "api/best_app/wishlist/byShop", method = RequestMethod.GET)
    public List<Wishlist> getWishlistByShopID(@RequestParam int shopID){
        return wishlistService.getWishlistByShopID(shopID);
    }

    @RequestMapping(value = "api/best_app/wishlist/create", method = RequestMethod.POST)
    public boolean addWishlist(@RequestBody WishlistDto wishlist){
        return wishlistService.addWishlist(wishlist);
    }
    @RequestMapping(value = "api/best_app/wishlist/update", method = RequestMethod.PUT)
    public boolean updateWishlist(@RequestBody WishlistDto wishlist){
        return wishlistService.updateWishlist(wishlist);
    }
    @RequestMapping(value = "api/best_app/wishlist/delete", method = RequestMethod.DELETE)
    public boolean removeWishlist(@RequestParam int id){
        return wishlistService.removeWishlist(id);
    }
}
