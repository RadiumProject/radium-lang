project=$1

mkdir $project
cd $project
mkdir src
cd src
echo 'include stdstream.h

pub fn main() {
	print("Hello, world!");
	return 0:
}
' >> main.ra 
cd ..
mkdir deps
cd deps
echo '
// you need write deps for project here
// example:
//LIBRARY=VERSION
' >> deps.conf
cd ..
echo "project is create"
