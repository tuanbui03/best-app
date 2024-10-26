package com.best.springbest.controller;

import com.best.springbest.dto.FeedbackDto;
import com.best.springbest.model.Feedback;
import com.best.springbest.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class FeedbackController {
    @Autowired
    FeedbackService feedbackService;
    @RequestMapping(value = "api/best_app/feedback/all", method = RequestMethod.GET)
    public List<Feedback> getAllFeedbacks(){
        return feedbackService.getAllFeedback();
    }
    @RequestMapping(value = "api/best_app/feedback/detail", method = RequestMethod.GET)
    public Feedback getFeedbackByID(@RequestParam int id){
        return feedbackService.getFeedbackByID(id);
    }
    @RequestMapping(value = "api/best_app/feedback/byProduct", method = RequestMethod.GET)
    public List<Feedback> getFeedbackByProductID( @RequestParam int productID){
        return feedbackService.getFeedbackByProductID(productID);}
    @RequestMapping(value = "api/best_app/feedback/byProductLimit", method = RequestMethod.GET)
    public List<Feedback> getFeedbackByProductIdLimit( @RequestParam int productID){
        return feedbackService.getFeedbackByProductIdLimit(productID);}

    @RequestMapping(value = "api/best_app/feedback/byShop", method = RequestMethod.GET)
    public List<Feedback> getFeedbackByShopID( @RequestParam int shopID){
        return feedbackService.getFeedbackByShopID(shopID);}

    @RequestMapping(value = "api/best_app/feedback/byProductIdAndUserID", method = RequestMethod.GET)
    public Feedback getFeedbackByProductIdAndUserID( @RequestParam int productID, @RequestParam int userID){
        return feedbackService.getFeedbackByProductIdAndUserID(productID, userID);}
    @RequestMapping(value = "api/best_app/feedback/create", method = RequestMethod.POST)
    public boolean addFeedback(@RequestBody FeedbackDto feedback){
        return feedbackService.addFeedback(feedback);
    }
    @RequestMapping(value = "api/best_app/feedback/update", method = RequestMethod.PUT)
    public boolean updateFeedback(@RequestBody FeedbackDto feedback){
        return feedbackService.updateFeedback(feedback);
    }
    @RequestMapping(value = "api/best_app/feedback/delete", method = RequestMethod.DELETE)
    public boolean removeFeedback(@RequestParam int id){
        return feedbackService.removeFeedback(id);
    }
}
