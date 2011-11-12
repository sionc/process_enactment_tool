# This model represents the pre-defined lifecycles. Many projects can be
# associated with a lifecycle, and each lifecycle has many lifecycle phases.

class Lifecycle < ActiveRecord::Base
 has_many :projects
 has_many :lifecycle_phases

 validates :name, :presence => true
end