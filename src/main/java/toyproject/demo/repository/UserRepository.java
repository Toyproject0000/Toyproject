package toyproject.demo.repository;

import lombok.Getter;
import lombok.Setter;
import toyproject.demo.domain.User;

import java.util.List;


public interface UserRepository {
    public void insert(User user);
    public void update(User user);
    public List<User> findAll();
    public List<User> findByIdAndPassword(String id, String password);
    public List<User> findFollower(String userId);
}
