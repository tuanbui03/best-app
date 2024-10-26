package com.best.springbest.service;

import com.best.springbest.model.Size;
import com.best.springbest.repository.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SizeService {
    @Autowired
    SizeRepository obRepository;

    public List<Size> getAllSize(){
        try{
            System.out.println("Data : " + obRepository.findAll());
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  Size getSizeByID(int id){
        try{
            return obRepository.findSizeByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addSize(Size ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateSize(Size ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeSize(int id){
        try{
            Size ob = obRepository.findSizeByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
