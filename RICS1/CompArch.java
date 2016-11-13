import java.time.Clock;
import java.time.Instant;

public class CompArch {
	static int overflowCounter=0;
	int recursiveDepth=0;
	private static Clock clock ;
	public static void main(String[] args) {
		int var=0;
		long time =System.nanoTime();
		for(int i=0; i< 10; i++){
			var += ackermann(3,6,0);
		}
		
		long time2 = System.nanoTime();	
		long offset = time2-time;
		offset /= 10 *1000;
		System.out.println("Average Time Taken in Micro seconds: " + offset + " Overflow Count: "+ overflowCounter/10);

	}
	private static int ackermann(int x, int y, int recursiveDepth){
		if(recursiveDepth > 15){
			overflowCounter++;
		}
		if(x==0){
			return y+1;
		}
		else if (y==0){
			return ackermann(x-1, 1, recursiveDepth+1);
		}else {
			return ackermann(x-1, ackermann(x, y-1, recursiveDepth+1), recursiveDepth+1);
		}
	}

}
