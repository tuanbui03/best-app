package com.best.springbest.controller;

import com.best.springbest.dto.MessageDto;
import com.best.springbest.model.Message;
import com.best.springbest.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class MessageController {
    @Autowired
    MessageService messageService;
    @RequestMapping(value = "api/best_app/message/all", method = RequestMethod.GET)
    public List<Message> getAllMessages(){
        return messageService.getAllMessage();
    }
    @RequestMapping(value = "api/best_app/message/detail", method = RequestMethod.GET)
    public Object getMessageByID(@RequestParam int id){
        return messageService.getMessageByID(id);
    }
    @RequestMapping(value = "api/best_app/message/create", method = RequestMethod.POST)
    public boolean addMessage(@RequestBody MessageDto ob) {
        return messageService.addMessage(ob);
    }
    @RequestMapping(value = "api/best_app/message/update", method = RequestMethod.PUT)
    public boolean updateMessage(@RequestBody MessageDto ob) {
        return messageService.updateMessage(ob);
    }
    @RequestMapping(value = "api/best_app/message/delete", method = RequestMethod.DELETE)
    public boolean removeMessage(@RequestParam int id){
        return messageService.removeMessage(id);
    }
}
