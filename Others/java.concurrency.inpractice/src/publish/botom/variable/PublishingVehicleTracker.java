package publish.botom.variable;

import java.util.Collections;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class PublishingVehicleTracker {
	private final Map<String,SafePoint> locations;
	private final Map<String,SafePoint> unmodifiableMap;
	public PublishingVehicleTracker(Map<String,SafePoint> location){
		this.locations = new ConcurrentHashMap<String,SafePoint>(location);
		this.unmodifiableMap = Collections.unmodifiableMap(this.locations);
	}
	public Map<String,SafePoint> getLocation(){
		return unmodifiableMap;
	}
	public SafePoint getLocation(String id){
		return locations.get(id);
	}
	public void setLocation(String id,int x,int y){
		if(!locations.containsKey(id)){
			throw new IllegalArgumentException("invalid vehicle name: "+id);
		}
		locations.get(id).set(x, y);
	}
}
