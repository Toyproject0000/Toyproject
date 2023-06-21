package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

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
        try {
            userRepository.findById(id);
            return "ok";
        }
        catch (Exception e){
            return "ID가 틀림";
        }
    }

    public String loginPassword(String password){
        try {
            userRepository.findByPassword(password);
            return "ok";
        }catch (Exception e){
            return "비번이 틀림";
        }
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


    public String authentication(String phoneNumber){

        return "ok";
    }





}