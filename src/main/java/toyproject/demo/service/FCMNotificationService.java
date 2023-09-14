package toyproject.demo.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.FCMNotificationRequestDto;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

import java.util.List;

@RequiredArgsConstructor
@Service
public class FCMNotificationService {

    private final FirebaseMessaging firebaseMessaging;
    private final UserRepository usersRepository;

    public String sendNotificationByToken(FCMNotificationRequestDto requestDto) {

        List<User> user = usersRepository.findById(requestDto.getId(), requestDto.getRoot());

        if (user.size()!=0) {
            if (user.get(0).getFirebaseToken() != null) {
                Notification notification = Notification.builder()
                        .setTitle(requestDto.getTitle())
                        .setBody(requestDto.getBody())
                        .build();

                Message message = Message.builder()
                        .setToken(user.get(0).getFirebaseToken())
                        .setNotification(notification)
                        .build();

                try {
                    firebaseMessaging.send(message);
                    return "알림을 성공적으로 전송했습니다. targetUserId=" + requestDto.getId();
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                    return "알림 보내기를 실패하였습니다. targetUserId=" + requestDto.getId();
                }
            } else {
                return "서버에 저장된 해당 유저의 FirebaseToken이 존재하지 않습니다. targetUserId=" + requestDto.getId();
            }

        } else {
            return "해당 유저가 존재하지 않습니다. targetUserId=" + requestDto.getId();
        }


    }
}
