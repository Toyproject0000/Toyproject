package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.MessageConverter;
import toyproject.demo.domain.DTO.MessageWithTokenDTO;
import toyproject.demo.domain.Message;
import toyproject.demo.service.JwtTokenUtil;
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
    private final MessageConverter messageConverter;
    private final JwtTokenUtil tokenUtil;
    @PostMapping(value = "/message/send", produces = "application/json;charset=UTF-8")
    public String sendMessage(@RequestBody MessageWithTokenDTO tokenMessage){
        try {
            tokenUtil.parseJwtToken(tokenMessage.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Message message = messageConverter.convert(tokenMessage);

        return messageService.send(message);
    }
    @PostMapping(value = "/message/findAll", produces = "application/json;charset=UTF-8")
    public Optional<List<Message>> findAllMessage(@RequestBody MessageWithTokenDTO tokenMessage){
        try {
            tokenUtil.parseJwtToken(tokenMessage.getToken());
        }catch (Exception e){
            return null;
        }
        Message message = messageConverter.convert(tokenMessage);
        return messageService.findAll(message);
    }
    @PostMapping(value = "/message/user", produces = "application/json;charset=UTF-8")
    public Optional<List<Message>> Message(@RequestBody MessageWithTokenDTO tokenMessage){
        try {
            tokenUtil.parseJwtToken(tokenMessage.getToken());
        }catch (Exception e){
            return null;
        }
        Message message = messageConverter.convert(tokenMessage);
        return messageService.findMessage(message);
    }

    @PostMapping(value = "/message/search", produces = "application/json;charset=UTF-8")
    public Optional<List<Message>> searchMessage(@RequestBody MessageWithTokenDTO tokenMessage){
        try {
            tokenUtil.parseJwtToken(tokenMessage.getToken());
        }catch (Exception e){
            return null;
        }
        Message message = messageConverter.convert(tokenMessage);
        return messageService.search(message);
    }
    @PostMapping(value = "/message/deleteAll", produces = "application/json;charset=UTF-8")
    public String deleteAllMessage(@RequestBody MessageWithTokenDTO tokenMessage){
        try {
            tokenUtil.parseJwtToken(tokenMessage.getToken());
        }catch (Exception e){
            return null;
        }
        Message message = messageConverter.convert(tokenMessage);

        return messageService.deleteAll(message);
    }

    @PostMapping(value = "/message/delete", produces = "application/json;charset=UTF-8")
    public String deleteMessage(@RequestBody MessageWithTokenDTO tokenMessage){
        try {
            tokenUtil.parseJwtToken(tokenMessage.getToken());
        }catch (Exception e){
            return null;
        }
        Message message = messageConverter.convert(tokenMessage);

        return messageService.delete(message);
    }
}
