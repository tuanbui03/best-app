package com.best.springbest.repository;

import com.best.springbest.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query("Select c from User c where c.id = ?1")
    User findUsersByID(int id);
    @Query("Select c from User c where c.email = ?1")
    User findUsersByEmail(String email);
}
