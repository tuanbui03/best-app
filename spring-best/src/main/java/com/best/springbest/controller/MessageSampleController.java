package com.best.springbest.controller;

import com.best.springbest.dto.MessageSampleDto;
import com.best.springbest.model.MessageSample;
import com.best.springbest.service.MessageSampleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class MessageSampleController {
    @Autowired
    MessageSampleService messageSampleService;
    @RequestMapping(value = "api/best_app/message_sample/all", method = RequestMethod.GET)
    public List<MessageSample> getAllMessageSamples(){
        return messageSampleService.getAllMessageSample();
    }
    @RequestMapping(value = "api/best_app/message_sample/detail", method = RequestMethod.GET)
    public Object getMessageSampleByID(@RequestParam int id){
        return messageSampleService.getMessageSampleByID(id);
    }
    @RequestMapping(value = "api/best_app/message_sample/create", method = RequestMethod.POST)
    public boolean addMessageSample(@RequestBody MessageSampleDto ob) {
        return messageSampleService.addMessageSample(ob);
    }
    @RequestMapping(value = "api/best_app/message_sample/update", method = RequestMethod.PUT)
    public boolean updateMessageSample(@RequestBody MessageSampleDto ob) {
        return messageSampleService.updateMessageSample(ob);
    }
    @RequestMapping(value = "api/best_app/message_sample/delete", method = RequestMethod.DELETE)
    public boolean removeMessageSample(@RequestParam int id){
        return messageSampleService.removeMessageSample(id);
    }
}
