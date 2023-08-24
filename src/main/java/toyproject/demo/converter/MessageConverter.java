package toyproject.demo.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.MessageWithTokenDTO;
import toyproject.demo.domain.Message;

@Service
public class MessageConverter implements Converter<MessageWithTokenDTO, Message> {

    @Override
    public Message convert(MessageWithTokenDTO source) {
        Message message = new Message();
        message.setMessage(source.getMessage());
        message.setDate(source.getDate());
        message.setId(source.getId());
        message.setSendUser(source.getSendUser());
        message.setAcceptUser(source.getAcceptUser());
        return message;
    }
}
