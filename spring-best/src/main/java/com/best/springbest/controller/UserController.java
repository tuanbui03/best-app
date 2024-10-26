package com.best.springbest.controller;

import com.best.springbest.model.User;
import com.best.springbest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class UserController {
    @Autowired
    UserService userService;
    @RequestMapping(value = "api/best_app/user/all", method = RequestMethod.GET)
    public List<User> getAllUsers(){
        return userService.getAllUser();
    }
    @RequestMapping(value = "api/best_app/user/detail", method = RequestMethod.GET)
    public User getUserByID(@RequestParam int id){
        return userService.getUserByID(id);
    }
    @RequestMapping(value = "api/best_app/user/byEmail", method = RequestMethod.GET)
    public boolean getUserByEmail(@RequestParam String email){
        return userService.findUserByEmail(email);
    }
    @RequestMapping(value = "api/best_app/login_user", method = RequestMethod.GET)
    public User loginUser(@RequestParam String email,String password){
        return userService.loginUser(email, password);
    }
    @RequestMapping(value = "api/best_app/user/create", method = RequestMethod.POST)
    public boolean addUser(@RequestBody User user){
        return userService.addUser(user);
    }
    @RequestMapping(value = "api/best_app/user/update", method = RequestMethod.PUT)
    public boolean updateUser(@RequestBody User user){
        return userService.updateUser(user);
    }
    @RequestMapping(value = "api/best_app/user/delete", method = RequestMethod.DELETE)
    public boolean removeUser(@RequestParam int id){
        return userService.removeUser(id);
    }
}
