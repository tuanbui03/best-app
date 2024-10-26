package com.best.springbest.service;

import com.best.springbest.dto.WishlistDto;
import com.best.springbest.handle.DateHanle;
import com.best.springbest.model.Product;
import com.best.springbest.model.User;
import com.best.springbest.model.Wishlist;
import com.best.springbest.repository.ProductRepository;
import com.best.springbest.repository.UserRepository;
import com.best.springbest.repository.WishlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class WishlistService {
    @Autowired
    WishlistRepository obRepository;
    @Autowired
    ProductRepository pRepository;
    @Autowired
    UserRepository uRepository;
    public List<Wishlist> getAllWishlist(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Wishlist getWishlistByID(int id){
        try{
            return obRepository.findWishlistsByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Wishlist> getWishlistByUserID(int id){
        try{
            return obRepository.findWishlistsByUserID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Wishlist> getWishlistByShopID(int id){
        try{
            return obRepository.findWishlistsByShop(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public Wishlist getWishlistByUserIDAndProductID(int userID, int productID){
        try{
            return obRepository.findWishlistsByUserIDAndProductID(userID, productID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addWishlist(WishlistDto ob){
        try{
            Product product = pRepository.findProductsByID(ob.getProduct_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new Wishlist(0,product,user,DateHanle.getDateNow(),null));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateWishlist(WishlistDto ob){
        try{
            Product product = pRepository.findProductsByID(ob.getProduct_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            Wishlist wishlist = obRepository.findWishlistsByID(ob.getId());
            obRepository.save(new Wishlist(ob.getId(),product,user,wishlist.getCreated_at(),DateHanle.getDateNow()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeWishlist(int id){
        try{
            Wishlist ob = obRepository.findWishlistsByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
