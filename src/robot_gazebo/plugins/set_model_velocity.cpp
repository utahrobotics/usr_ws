#include <functional>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>
#include <gazebo/common/Plugin.hh>
#include <ros/ros.h>
#include <geometry_msgs/Twist.h>

namespace gazebo
{
  //////////////////////////////////////////////////
  /// \brief Sets velocity on a link or joint
  class SetVelocityPlugin : public ModelPlugin
  {

    private: physics::ModelPtr model;
    private: event::ConnectionPtr updateConnection;
    //ros members
    private: ros::Subscriber sub;
    private: ros::NodeHandle n;

    private: ignition::math::Vector3d update_vel;
    private: ignition::math::Vector3d update_ang;

    public: SetVelocityPlugin() : ModelPlugin(){
        printf("loading drive plugin\n");
        this->sub = n.subscribe("/cmd_vel", 5, &SetVelocityPlugin::changeVel, this);
    }

    public: virtual void Load(physics::ModelPtr _model, sdf::ElementPtr _sdf)
      {
        //check if roscore is initialized
        if (!ros::isInitialized()){
            ROS_FATAL_STREAM("A ROS node for Gazebo has not been initialized, unable to load plugin. "
        << "Load the Gazebo system plugin 'libgazebo_ros_api_plugin.so' in the gazebo_ros package)");
            return;
        }

        //initialize update vectors
        this->update_vel = ignition::math::Vector3d(0, 0, 0);
        this->update_ang = ignition::math::Vector3d(0, 0, 0);

        //initialize listener node
        this->model = _model;
        this->updateConnection = event::Events::ConnectWorldUpdateBegin(
        std::bind(&SetVelocityPlugin::Update, this, std::placeholders::_1));
      }

    public: void Update(const common::UpdateInfo &_info)
      {
        //set the linear velocity of the link
        this->model->SetLinearVel(this->update_vel);
        this->model->SetAngularVel(this->update_ang);
    };
    public: void changeVel(const geometry_msgs::Twist& msg){
        this->update_vel = ignition::math::Vector3d(msg.linear.x, msg.linear.y, msg.linear.z);
        this->update_ang = ignition::math::Vector3d(0, 0, msg.angular.z);

    }
  };

  GZ_REGISTER_MODEL_PLUGIN(SetVelocityPlugin)
}
