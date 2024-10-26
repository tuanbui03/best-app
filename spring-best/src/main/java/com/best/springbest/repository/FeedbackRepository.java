package com.best.springbest.repository;

import com.best.springbest.model.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Long> {
    @Query("Select f from Feedback f where f.id = ?1")
    Feedback findFeedbacksByID(int id);

    @Query("select f from Feedback f where  f.product.id = ?1 and f.user.id = ?2")
    Feedback findFeedbackByProductIdAndUserID( int productID, int userID);
    @Query("select f from Feedback f where  f.product.id = ?1")
    List<Feedback> findFeedbackByProductID( int productID);
    @Query("select f from Feedback f where  f.product.shop.id = ?1")
    List<Feedback> findFeedbackByShopID( int shopID);
    @Query(nativeQuery = true, value = "select * from feedbacks f where  f.product_id = ?1 limit 2")
    List<Feedback> findFeedbackByProductIdLimit( int productID);
}
