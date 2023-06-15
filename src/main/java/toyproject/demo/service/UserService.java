package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
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

    public String login(String id, String password){
        try {
            userRepository.findByIdAndPassword(id, password);
            return "ok";
        }
        catch (Exception e){
            return "cancel";
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





}