package com.best.springbest.service;

import com.best.springbest.dto.*;
import com.best.springbest.model.*;
import com.best.springbest.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageService {
    @Autowired
    MessageRepository obRepository;
    @Autowired
    MessageSampleRepository messageSampleRepository;
    @Autowired
    UserRepository uRepository;
    public List<Message> getAllMessage(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Message getMessageByID(int id){
        try{
            return obRepository.findMessageByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addMessage(MessageDto ob){
        try{
            MessageSample messageSample = messageSampleRepository.findMessageSampleByID(ob.getMessage_sample_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new Message(0,user,messageSample,ob.getDate_sent(),ob.getDate_read(), ob.getContent()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateMessage(MessageDto ob){
        try{
            MessageSample messageSample = messageSampleRepository.findMessageSampleByID(ob.getMessage_sample_id());
            User user = uRepository.findUsersByID(ob.getUser_id());
            obRepository.save(new Message(ob.getId(),user,messageSample,ob.getDate_sent(),ob.getDate_read(), ob.getContent()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeMessage(int id){
        try{
            Message ob = obRepository.findMessageByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
