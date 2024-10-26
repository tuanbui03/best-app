package com.best.springbest.controller;

import com.best.springbest.dto.MessageRecipientDto;
import com.best.springbest.model.MessageRecipient;
import com.best.springbest.service.MessageRecipientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class MessageRecipientController {
    @Autowired
    MessageRecipientService messageRecipientService;
    @RequestMapping(value = "api/best_app/message_recipient/all", method = RequestMethod.GET)
    public List<MessageRecipient> getAllMessageRecipients(){
        return messageRecipientService.getAllMessageRecipient();
    }
    @RequestMapping(value = "api/best_app/message_recipient/detail", method = RequestMethod.GET)
    public Object getMessageRecipientByID(@RequestParam int id){
        return messageRecipientService.getMessageRecipientByID(id);
    }
    @RequestMapping(value = "api/best_app/message_recipient/create", method = RequestMethod.POST)
    public boolean addMessageRecipient(@RequestBody MessageRecipientDto ob) {
        return messageRecipientService.addMessageRecipient(ob);
    }
    @RequestMapping(value = "api/best_app/message_recipient/update", method = RequestMethod.PUT)
    public boolean updateMessageRecipient(@RequestBody MessageRecipientDto ob) {
        return messageRecipientService.updateMessageRecipient(ob);
    }
    @RequestMapping(value = "api/best_app/message_recipient/delete", method = RequestMethod.DELETE)
    public boolean removeMessageRecipient(@RequestParam int id){
        return messageRecipientService.removeMessageRecipient(id);
    }
}
