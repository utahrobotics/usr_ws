#include <gazebo/common/Plugin.hh>
#include <ros/ros.h>

namespace gazebo {
    class drive_plugin : public ModelPlugin
    {
    private:
        /* data */
    public:
        drive_plugin(/* args */);
        ~drive_plugin();
    };
    
    drive_plugin::drive_plugin(/* args */)
    {
    }
    
    drive_plugin::~drive_plugin()
    {
    }
    
}