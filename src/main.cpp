#include <iostream>
#include <Eigen/Core>
#include "geometry/quat.h"


int main()
{
  std::cout << "Hello, world!" << std:: endl;

  Eigen::Vector3d vec3{1,2,3};
  std::cout << "vec3: " << vec3.transpose() << std::endl;

  quat::Quatd quat = quat::Quatd::from_euler(0,0,0);
  std::cout << "quat: " << quat.elements().transpose() << std::endl;

  return 0;
}

