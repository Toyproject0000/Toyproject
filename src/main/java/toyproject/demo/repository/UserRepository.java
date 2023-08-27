package toyproject.demo.repository;

import lombok.Getter;
import lombok.Setter;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.User;

import java.util.List;


public interface UserRepository {
    public void insert(User user);
    public void update(User user,String userId);
    public void delete(User user);
    public List<User> findById(String id);
    public List<User> findFollower(String userId);
    public List<User> findUserByNameAndPhone(User user);
    public List<User> findUserByNameAndPhoneAndId(User user);
    public List<User> findNickname(User user);
    public List<User> findEmail(User user);
    public void setPassword(User user);
    public List<ProfileViewDTO> findUser(String id);
    List<ProfileDTO> userProfile(String id);
}
