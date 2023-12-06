import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping(path="/demo")
public class DemoController {

    @GetMapping("/hello")
    public ResponseEntity<?> hello() {
        try{
            return new ResponseEntity<>("hello!!! Springboot is okay :3",HttpStatusCode.valueof(200));

        }catch (Exception ex){
            return new ResponseEntity<>("Error running Springboot...",HttpStatus.INTERNAL_SERVER_ERROR);
            
        }
        
    }
    
}
