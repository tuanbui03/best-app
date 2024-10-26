package com.best.springbest.service;

import com.best.springbest.dto.MessageSampleDto;
import com.best.springbest.model.*;
import com.best.springbest.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MessageSampleService {
    @Autowired
    MessageSampleRepository obRepository;
    @Autowired
    ShopRepository shopRepository;
    public List<MessageSample> getAllMessageSample(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public MessageSample getMessageSampleByID(int id){
        try{
            return obRepository.findMessageSampleByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public boolean addMessageSample(MessageSampleDto ob){
        try{
            Shop shop = shopRepository.findShopByID(ob.getShop_id());
            obRepository.save(new MessageSample(0,shop, ob.getQuestion(), ob.getAnswer()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateMessageSample(MessageSampleDto ob){
        try{
            Shop shop = shopRepository.findShopByID(ob.getShop_id());
            obRepository.save(new MessageSample(ob.getId(),shop, ob.getQuestion(), ob.getAnswer()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeMessageSample(int id){
        try{
            MessageSample ob = obRepository.findMessageSampleByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
