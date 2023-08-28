package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.User;
import toyproject.demo.repository.CategoryRepository;
import toyproject.demo.repository.UserRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;

    public String join(User user){
        try {
            userRepository.insert(user);
            categoryRepository.insert(user.getId(), user.getRoot());
            return "ok";
        }
        catch (Exception e){
            System.out.println(e.getMessage());
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
        if (result.size()==0) return "cancel";
        else return "ok";
    }
    public Boolean findEmail(User user){
        List<User> result = userRepository.findEmail(user);
        if (result.size()==0) return false;
        return true;
    }

    public String duplicateNick(User user){
        List<User> users = userRepository.findNickname(user);
        if(users.size()!=0){
            return "cancel";
        }
        return "ok";
    }

    public String setPassword(User user){
        try {
            userRepository.setPassword(user);
            return "ok";
        }
        catch (Exception e){
            return "cancel";
        }
    }

    public List<ProfileViewDTO> findUser(String id){
        List<ProfileViewDTO> result = userRepository.findUser(id);
        return result;
    }


    public String login(User user){
        List<User> findUser = userRepository.findById(user.getId());
        if(findUser.size()!=1||!findUser.get(0).getId().equals(user.getId())){
            return "id 오류";
        }
        if (!findUser.get(0).getPassword().equals(user.getPassword())){
            return "비번 오류";
        }
        if (findUser.get(0).getNickname()==null) return "닉네임 설정 안됨";

        return ",\n\"id\" : \""+findUser.get(0).getId()+"\",\n\"nickname\" : \""+findUser.get(0).getNickname()+"\"}";
    }

    public String socialLogin(User user){
        List<User> findUser = userRepository.findById(user.getId());
        if(findUser.size()!=1||!findUser.get(0).getId().equals(user.getId())){
            return "id 오류";
        }
        if (!findUser.get(0).getRoot().equals(user.getRoot())){
            return "잘못된 접근입니다.";
        }
        if (findUser.get(0).getNickname()==null) return "닉네임 설정 안됨";

        return ",\n\"id\" : \""+findUser.get(0).getId()+"\",\n\"nickname\" : \""+findUser.get(0).getNickname()+"\"}";
    }


    public String edit(User user, String userId){
        try {
            userRepository.update(user, userId);
            return "ok";
        }
        catch (Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getMessage());
            return "cancel";
        }
    }

    public List<ProfileDTO> userProfile(String id){
        return userRepository.userProfile(id);
    }

    public void delete(User user){
        userRepository.delete(user);
    }



}