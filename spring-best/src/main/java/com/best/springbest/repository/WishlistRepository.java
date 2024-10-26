package com.best.springbest.repository;

import com.best.springbest.model.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
    @Query("Select c from Wishlist c where c.id = ?1")
    Wishlist findWishlistsByID(int id);
    @Query("Select c from Wishlist c where c.user.id = ?1")
    List<Wishlist> findWishlistsByUserID(int id);

    @Query("Select c from Wishlist c where c.product.shop.id = ?1")
    List<Wishlist> findWishlistsByShop(int shopID);
    @Query("select w from Wishlist w where w.user.id =?1 and  w.product.id = ?2")
    Wishlist findWishlistsByUserIDAndProductID(int userID, int productID);
}
