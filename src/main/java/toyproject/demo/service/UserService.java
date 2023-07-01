package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final SmsService smsService;

    public UserService(UserRepository userRepository, SmsService smsService) {
        this.userRepository = userRepository;
        this.smsService = smsService;
    }

    public String join(User user){
        try {
            userRepository.insert(user);
            return "ok";
        }
        catch (Exception e){
            return "cancel";
        }
    }

    public String findId(User user){
        List<User> result = userRepository.findUserByNameAndPhone(user);
        if (result.size()==0) return "가입되어 있지않음";
        else return result.get(0).getId();
    }

    public String findPassword(User user){
        List<User> result = userRepository.findUserByNameAndPhoneAndId(user);
        if (result.size()==0) return "정보가 틀림";
        else return result.get(0).getPassword();
    }


    public String login(User user){
        List<User> findUser = userRepository.findById(user.getId());
        if(findUser.size()!=1||!findUser.get(0).getId().equals(user.getId())){
            return "id 오류";
        }
        if (!findUser.get(0).getPassword().equals(user.getPassword())){
            return "비번 오류";
        }
        return "ok";
    }


    public String edit(User user){
        try {
            userRepository.update(user);
            return "ok";
        }
        catch (Exception e){
            return "cancel";
        }
    }

    public void delete(User user){
        userRepository.delete(user);
    }


    public String authentication(String phoneNumber){

        return "ok";
    }





}