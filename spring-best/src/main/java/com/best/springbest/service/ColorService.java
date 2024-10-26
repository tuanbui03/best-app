package com.best.springbest.service;

import com.best.springbest.model.Color;
import com.best.springbest.repository.ColorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ColorService {
    @Autowired
    ColorRepository obRepository;

    public List<Color> getAllColor(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  Color getColorByID(int id){
        try{
            return obRepository.findColorByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addColor(Color ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateColor(Color ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeColor(int id){
        try{
            Color ob = obRepository.findColorByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
