package com.best.springbest.service;

import com.best.springbest.model.User;
import com.best.springbest.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {
    @Autowired
    UserRepository obRepository;

    public List<User> getAllUser(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public User getUserByID(int id){
        try{
            return obRepository.findUsersByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean findUserByEmail(String str){
        try{
            User user = obRepository.findUsersByEmail(str);
            if(user != null){
                return  true;
            }
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
    public boolean addUser(User ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateUser(User ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeUser(int id){
        try{
            User ob = obRepository.findUsersByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public User loginUser(String email, String password){
        try{
            User user = obRepository.findUsersByEmail(email);
            if(user != null && user.getPassword().equals(password)){
                return user;
            }
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
}
