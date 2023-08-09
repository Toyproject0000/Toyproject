package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import toyproject.demo.domain.Message;
import toyproject.demo.service.MessageService;

import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class MessageController {
    /**
     * 보내기
     * 나랑 대화 나눈 사람 찾기
     * 메세지 내용
     * 대화 검색
     * 삭제 - 대화 전체 삭제
     * 대화 일부 삭제?
     */
    private final MessageService messageService;
    @PostMapping("/message/send")
    public String sendMessage(@SessionAttribute("SessionId") String userId, Message message){
        if (userId != message.getSendUser()){
            return "잘못된 접근입니다.";
        }
        return messageService.send(message);
    }
    @PostMapping("/message/findAll")
    public Optional<List<Message>> findAllMessage(@SessionAttribute("SessionId") String userId, Message message){
        if (userId != message.getSendUser()||userId!=message.getAcceptUser()){
            return null;
        }
        return messageService.findAll(message);
    }
    @PostMapping("/message/user")
    public Optional<List<Message>> Message(@SessionAttribute("SessionId") String userId, Message message){
        if (userId != message.getSendUser()||userId!=message.getAcceptUser()){
            return null;
        }
        return messageService.findMessage(message);
    }

    @PostMapping("/message/search")
    public Optional<List<Message>> searchMessage(@SessionAttribute("SessionId") String userId, Message message){
        if (userId != message.getSendUser()||userId!=message.getAcceptUser()){
            return null;
        }
        return messageService.search(message);
    }
    @PostMapping("/message/deleteAll")
    public String deleteAllMessage(@SessionAttribute("SessionId") String userId, Message message){
        if (userId != message.getSendUser()||userId!=message.getAcceptUser()){
            return "잘못된 접근입니다.";
        }
        return messageService.deleteAll(message);
    }

    @PostMapping("/message/delete")
    public String deleteMessage(@SessionAttribute("SessionId") String userId, Message message){
        if (userId != message.getSendUser()||userId!=message.getAcceptUser()){
            return "잘못된 접근입니다.";
        }
        return messageService.delete(message);
    }
}
