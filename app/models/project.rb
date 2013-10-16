class Project < ActiveRecord::Base
  belongs_to :cohort, inverse_of: :projects
  has_many :groups, inverse_of: :project, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :link
  validates_presence_of :cohort

  def sort_random_pairs(size)
    students = self.cohort.users.where(role: 'student').to_a

    create_groups(students) while students.length >= size
    sort_remaining(students)
  end

  private

  def create_groups(students)
    group = Group.create(project_id: self.id)
    pair = nil
    current_student = students.pop
    students.each do |s|
      current_student.pairs.include?(s) ? next : pair = s
    end
    students.delete(pair)
    GroupMembership.create(group_id: group.id, user_id: current_student.id)
    GroupMembership.create(group_id: group.id, user_id: pair.id)
  end

  def sort_remaining(students)
    students.length.times do |n|
      student = students.pop
      groups = Group.where(project_id: self.id).to_a
      GroupMembership.create(group_id: groups[n].id, user_id: student.id)
    end
  end
end
