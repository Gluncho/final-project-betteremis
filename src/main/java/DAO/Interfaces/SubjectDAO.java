package DAO.Interfaces;

import Model.Student;
import Model.Subject;

import java.util.List;

public interface SubjectDAO {
    /**
     * Adds a new subject in the database, if there isn't a subject with this name.
     * This is because subject's name is unique. For this reason information for two lecturers' teaching the same subject
     * cannot be saved in this table.
     * @param subject Subject to be added.
     * @return ture if added successfully, false otherwise.
     */
    boolean addSubject(Subject subject);

    /**
     * Removes the subject with a given name. Since the subject is unique in table only name is sufficient.
     * @param subjectName Name of the subject.
     * @return true if subject was removed successfully, false otherwise.
     */
    boolean removeSubject(String subjectName);

    /**
     * Given the subject name, returns its respective subject object.
     * @param subjectName Name of the subject.
     * @return Subject object containing the information. If subject could not be retrieved null is returned.
     */
    Subject getSubjectByName(String subjectName);

    /**
     * Finds all the students who are enrolled in this course and returns them
     * as a list of Student objects.
     * @return List of students enrolled in this subject.
     */
    List<Student> getEnrolledStudents(int subject_id);
}
