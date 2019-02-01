package trm.dao.trainingschedule;

import java.sql.Date;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import trm.dao.DAOJDBCTemplate;


/**
 * CRUD Service for Training Schedule
 * @author Kei Ng
 */
public class TrainingScheduleCRUDService {
	
	private JdbcTemplate jtemp;
	
	public static void main(String[] args) {
		//int i = new TrainingScheduleCRUDService().getAllTrainingSchedule().size();
		//System.out.println(i);
		
		//List<TrainingSchedule> sc= new TrainingScheduleCRUDService().getAllTrainingSchedule();
		//System.out.println(sc.get(0).getTraining_schedule_id());
		int i = new TrainingScheduleCRUDService().updateTrainingSchedule("9876543211", "Boston", "MA", "US", "12345", "EST", "542 st", "R210", null, null);
		System.out.println(i);
	}
	
	
	/**
	 * Query: get all training schedule
	 * @return List<TrainingSchedule>
	 */
	public List<TrainingSchedule> getAllTrainingSchedule(){
		jtemp = DAOJDBCTemplate.getJdbcTemplate();
		List<TrainingSchedule> scheduleList = jtemp.query("Select * from TRAINING_SCHEDULE", new TrainingScheduleMapper());
		return scheduleList;
	}
	
	/**
	 * Query: Delete training schedule
	 * @param training_schedule_id
	 * @return int(bollean)
	 */
	public int deleteTrainingSchedule(String training_schedule_id) {
		jtemp = DAOJDBCTemplate.getJdbcTemplate();
		int ret = jtemp.update("delete from TRAINING_SCHEDULE where training_schedule_id = ?", 
				new Object[] {training_schedule_id});
		return ret;
	}
	
	/**
	 * Get training schedule by id
	 * @param training_schedule_id
	 * @return TrainingSchedule
	 */
	public TrainingSchedule getTrainingScheduleById(String training_schedule_id) {
		jtemp = DAOJDBCTemplate.getJdbcTemplate();
		TrainingSchedule schedule = jtemp.queryForObject("Select * from TRAINING_SCHEDULE where training_schedule_id = ?",
									new Object[]{training_schedule_id},
									new TrainingScheduleMapper());
		return schedule;
	}
	
	/**
	 * Query: update training schedule 
	 * @param training_schedule_id
	 * @param training_city
	 * @param training_state
	 * @param training_country
	 * @param training_zipcode
	 * @param training_time_zone
	 * @param training_location
	 * @param training_room_number
	 * @param training_start_date
	 * @param training_end_date
	 * @return
	 */
	public int updateTrainingSchedule(String training_schedule_id, String training_city, String training_state,
			String training_country, String training_zipcode, String training_time_zone, String training_location,
			String training_room_number, Date training_start_date, Date training_end_date) {
		jtemp = DAOJDBCTemplate.getJdbcTemplate();
		int ret = jtemp.update("UPDATE TRAINING_SCHEDULE SET training_city = ?, training_state = ?, training_country = ?, training_zipcode = ?, training_time_zone = ?, training_location = ?, training_room_number = ?, training_start_date = ?, training_end_date = ? where training_schedule_id = ?",
							new Object[] {
									training_city,
									training_state,
									training_country,
									training_zipcode,
									training_time_zone,
									training_location,
									training_room_number,
									training_start_date,
									training_end_date,
									training_schedule_id});
		return ret;
	}
	
	
	/**
	 * Query: insert new training schedule
	 * @param schedule
	 * @return int(boolean)
	 */
	public int insertTrainingSchedule(TrainingSchedule schedule) {
		jtemp = DAOJDBCTemplate.getJdbcTemplate();
		int ret = jtemp.update("insert into TRAINING_SCHEDULE values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
								new Object[] {
										schedule.getTraining_schedule_id(),
										schedule.getTraining_city(),
										schedule.getTraining_state(),
										schedule.getTraining_country(),
										schedule.getTraining_zipcode(),
										schedule.getTraining_time_zone(),
										schedule.getTraining_location(),
										schedule.getTraining_room_number(),
										schedule.getTraining_start_date(),
										schedule.getTraining_end_date()});
		return ret;
	}
}