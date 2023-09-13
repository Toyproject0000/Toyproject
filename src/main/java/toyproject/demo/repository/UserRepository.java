package toyproject.demo.repository;

import lombok.Getter;
import lombok.Setter;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.FCMNotificationRequestDto;
import toyproject.demo.domain.User;

import java.util.List;


 public interface UserRepository {
     void insert(User user);
     void update(User user,String userId);
     void delete(User user);
     void setToken(FCMNotificationRequestDto fcm);
     String getToken(FCMNotificationRequestDto fcm);
     List<User> findById(String id, String userRoot);
     List<User> findFollower(String userId);
     List<User> findUserByNameAndPhone(User user);
     List<User> findUserByNameAndPhoneAndId(User user);
     List<User> findNickname(User user);
     List<User> findEmail(User user);
     void setPassword(User user);
     List<ProfileViewDTO> findUser(String id, String root);
     List<ProfileDTO> userProfile(String id, String root,String loginId, String loginRoot);
     List<User> findUserByPhone(String phoneNumber);
}
