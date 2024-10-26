package com.best.springbest.service;

import com.best.springbest.dto.MessageRecipientDto;
import com.best.springbest.model.*;
import com.best.springbest.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MessageRecipientService {
    @Autowired
    MessageRecipientRepository obRepository;
    @Autowired
    MessageRepository messageRepository;
    @Autowired
    UserRepository uRepository;
    public List<MessageRecipient> getAllMessageRecipient(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public MessageRecipient getMessageRecipientByID(int id){
        try{
            return obRepository.findMessageRecipientByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addMessageRecipient(MessageRecipientDto ob){
        try{
            Message message = messageRepository.findMessageByID(ob.getMessage_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new MessageRecipient(0,message,user));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateMessageRecipient(MessageRecipientDto ob){
        try{

            Message message = messageRepository.findMessageByID(ob.getMessage_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new MessageRecipient(0,message,user));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeMessageRecipient(int id){
        try{
            MessageRecipient ob = obRepository.findMessageRecipientByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
