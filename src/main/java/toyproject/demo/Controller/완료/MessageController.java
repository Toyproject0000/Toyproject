package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
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
    @PostMapping(value = "/message/send", produces = "application/json;charset=UTF-8")
    public String sendMessage(@RequestBody Message message){
        return messageService.send(message);
    }
    @PostMapping(value = "/message/findAll", produces = "application/json;charset=UTF-8")
    public Optional<List<Message>> findAllMessage(@RequestBody Message message){
        return messageService.findAll(message);
    }
    @PostMapping(value = "/message/user", produces = "application/json;charset=UTF-8")
    public Optional<List<Message>> Message(@RequestBody Message message){
        return messageService.findMessage(message);
    }

    @PostMapping(value = "/message/search", produces = "application/json;charset=UTF-8")
    public Optional<List<Message>> searchMessage(@RequestBody Message message){
        return messageService.search(message);
    }
    @PostMapping(value = "/message/deleteAll", produces = "application/json;charset=UTF-8")
    public String deleteAllMessage(@RequestBody Message message){

        return messageService.deleteAll(message);
    }

    @PostMapping(value = "/message/delete", produces = "application/json;charset=UTF-8")
    public String deleteMessage(@RequestBody Message message){

        return messageService.delete(message);
    }
}
