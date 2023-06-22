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

    public String loginId(String id){
        List<User> result = userRepository.findById(id);
        if (result.size()==0) return "ID가 틀림";
        else return "ok";
    }

    public String loginPassword(String password){
        List<User> result = userRepository.findByPassword(password);
        if (result.size()==0) return "비번이 틀림";
        else return "ok";
    }
    /*
    * 로그인 메소드 따로 만들고
    * 아이디찾기, 비번찾기용으로 바꾸기
    * */


    public String edit(User user){
        try {
            userRepository.update(user);
            return "ok";
        }
        catch (Exception e){
            return "cancel";
        }
    }


    public String authentication(String phoneNumber){

        return "ok";
    }





}