package toyproject.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MakeCertificationNumber {

    private final BCryptPasswordEncoder encoder;
    @Autowired
    public MakeCertificationNumber() {
        this.encoder = new BCryptPasswordEncoder();
    }

    public String makeNumber(String num){
        return encoder.encode(num);
    }

    public Boolean match(String rawNum, String certificatedNum){
        return encoder.matches(rawNum, certificatedNum);

    }
}