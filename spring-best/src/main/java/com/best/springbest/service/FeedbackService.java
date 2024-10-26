package com.best.springbest.service;

import com.best.springbest.dto.FeedbackDto;
import com.best.springbest.handle.DateHanle;
import com.best.springbest.model.*;
import com.best.springbest.repository.FeedbackRepository;
import com.best.springbest.repository.ProductRepository;
import com.best.springbest.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FeedbackService {
    @Autowired
    FeedbackRepository obRepository;
    @Autowired
    ProductRepository pRepository;
    @Autowired
    UserRepository uRepository;
    public List<Feedback> getAllFeedback(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Feedback getFeedbackByID(int id){
        try{
            return obRepository.findFeedbacksByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Feedback getFeedbackByProductIdAndUserID(int productID, int userID){
        try{
            return obRepository.findFeedbackByProductIdAndUserID( productID, userID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<Feedback> getFeedbackByProductID(int productID){
        try{
            return obRepository.findFeedbackByProductID( productID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<Feedback> getFeedbackByProductIdLimit(int productID){
        try{
            return obRepository.findFeedbackByProductIdLimit(productID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<Feedback> getFeedbackByShopID(int shopID){
        try{
            return obRepository.findFeedbackByShopID( shopID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addFeedback(FeedbackDto ob){
        try{
            Product product = pRepository.findProductsByID(ob.getProduct_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new Feedback(0,user,product,ob.getContent(),ob.getVote(),DateHanle.getDateNow()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateFeedback(FeedbackDto ob){
        try{
            Product product = pRepository.findProductsByID(ob.getProduct_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new Feedback(ob.getId(),user,product,ob.getContent(),ob.getVote(),DateHanle.getDateNow()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeFeedback(int id){
        try{
            Feedback ob = obRepository.findFeedbacksByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
