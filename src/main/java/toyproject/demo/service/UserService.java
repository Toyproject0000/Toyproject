package toyproject.demo.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.FCMNotificationRequestDto;
import toyproject.demo.domain.User;
import toyproject.demo.repository.CategoryRepository;
import toyproject.demo.repository.UserRepository;
import toyproject.demo.repositoryImpl.AuthenticationRepositoryImpl;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {
    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final SmsService smsService;
    private final MailService mailService;
    private final AuthenticationRepositoryImpl authenticationRepository;

    @Transactional
    public String join(User user){
        try {
            userRepository.insert(user);
            categoryRepository.insert(user.getId(), user.getRoot());
            return "ok";
        }
        catch (DuplicateKeyException e){
            log.error("error", e);
            if (e.getMessage().contains(user.getNickname())) {
                return "닉네임이 사용중입니다.";
            }
            return "이미 가입된 아이디입니다.";
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return "cancel";
        }
    }

    public String duplicateNick(User user){
        List<User> users = userRepository.findNickname(user);
        if(users.size()!=0){
            return "사용중인 닉네임입니다.";
        }
        return "사용가능한 닉네임입니다.";
    }

    public List<ProfileViewDTO> findUser(String id, String root){
        List<ProfileViewDTO> result = userRepository.findUser(id, root);
        return result;
    }

    public String findId(User user, String random) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException {
        List<User> findUsers = userRepository.findUserByNameAndPhone(user);
        if (findUsers.size()==1){
            smsService.sendSms(user.getPhoneNumber(), random);
            return "인증번호가 전송되었습니다.";
        }
        return "가입이력이 없습니다.";
    }

    public String findIdCheck(String phoneNumber){
        List<User> phone = userRepository.findUserByPhone(phoneNumber);
        return phone.get(0).getId();
    }

    public Boolean findEmail(User user){
        User findUser = userRepository.findUserByNameAndPhoneAndId(user).get(0);
        if (findUser.getId().equals(user.getId())&&findUser.getName().equals(user.getName())&&findUser.getPhoneNumber().equals(user.getPhoneNumber())){
            String num = mailService.sendMail(user.getId());
            authenticationRepository.insert(user.getId(), num);
            return true;
        }
        return false;
    }

    public String getToken(FCMNotificationRequestDto fcm){
        return userRepository.getToken(fcm);
    }

    public void setToken(FCMNotificationRequestDto fcm){
        userRepository.setToken(fcm);
    }

    @Transactional
    public Boolean findPassword(String id, String num){
        Integer realNum = authenticationRepository.find(id);
        if (realNum.equals(num)){
            authenticationRepository.delete(id);
            return true;
        }
        return false;
    }

    public String setPassword(User user){
        try {
            userRepository.setPassword(user);
            return "변경완료";
        }catch (Exception e){
            return "다시 시도해주세요";
        }
    }


    public String login(User user){
        List<User> findUser = userRepository.findById(user.getId(), user.getRoot());
        if(findUser.size()!=1||!findUser.get(0).getId().equals(user.getId())){
            return "id 오류";
        }
        if (!findUser.get(0).getPassword().equals(user.getPassword())){
            return "비번 오류";
        }

        return ",\n\"id\" : \""+findUser.get(0).getId()+"\",\n\"nickname\" : \""+findUser.get(0).getNickname()+"\"}";
    }

    public String socialLogin(User user){
        List<User> findUser = userRepository.findById(user.getId(), user.getRoot());
        if(findUser.size()!=1||!findUser.get(0).getId().equals(user.getId())){
            return "id 오류";
        }
        if (!findUser.get(0).getRoot().equals(user.getRoot())||findUser.get(0).getRoot().equals("local")){
            return "잘못된 접근입니다.";
        }


        return ",\n\"id\" : \""+findUser.get(0).getId()+"\",\n\"nickname\" : \""+findUser.get(0).getNickname()+"\"}";
    }


    public String edit(User user, String userId){
        try {
            userRepository.update(user, userId);
            return "ok";
        }
        catch (Exception e){
            return "cancel";
        }
    }

    public List<ProfileDTO> userProfile(String id, String root, String loginId, String loginRoot){
        return userRepository.userProfile(id, root, loginId, loginRoot);
    }

    public void delete(User user){
        userRepository.delete(user);
    }



}