require "ecr/macros"
require "colorize"

def write(directory : String, filename : String, content : String, verbose : Bool)
    File.write("#{directory}/#{filename}", content)
    if verbose == true
        puts "#{"INFO:".colorize(:blue)} Created file #{filename}"
    end
end

def prompt(prompt : String) : String
    print "#{prompt} > "
    return gets || ""
end

class Creator
    private def Creator.checks(directory : String)
        is_empty = true
        begin
            is_empty = Dir.empty?(directory)
        rescue File::NotFoundError
            Dir.mkdir(directory)
            puts "#{"INFO:".colorize(:blue)} Creating directory #{directory.colorize(:green)}"
        end

        if is_empty == false
            puts "#{"ERROR:".colorize(:red)} Directory #{directory.colorize(:green)} is not empty"
            exit(1)
        end
    end

    def Creator.python(project_name : String, verbose : Bool, directory : String)
        self.checks(directory)

        author = prompt("Enter author")
        description = prompt("Enter package description")
        repo = prompt("Enter repo url")

        c=ECR.render "src/templates/python/setup.py.ecr"
        write(directory, "setup.py", c, verbose)

        c=ECR.render "src/templates/python/README.rst.ecr"
        write(directory, "README.rst", c, verbose)

        c=ECR.render "src/templates/python/justfile.ecr"
        write(directory, "justfile", c, verbose)

        c=ECR.render "src/templates/python/pyproject.toml.ecr"
        write(directory, "pyproject.toml", c, verbose)

        c=ECR.render "src/templates/python/.gitignore.ecr"
        write(directory, ".gitignore", c, verbose)

        Dir.mkdir("#{directory}/tests")
        write(directory, "tests/__init__.py", "", verbose)

        Dir.mkdir("#{directory}/#{project_name}")

        c=ECR.render "src/templates/python/__init__.py.ecr"
        write(directory, "#{project_name}/__init__.py", c, verbose)
        write(directory, "#{project_name}/py.typed", "", verbose)

        Dir.mkdir("#{directory}/docs")

        Dir.mkdir("#{directory}/docs/_build")
        write(directory, "docs/_build/.gitkeep", "", verbose)

        Dir.mkdir("#{directory}/docs/_static")
        write(directory, "docs/_static/.gitkeep", "", verbose)

        Dir.mkdir("#{directory}/docs/_templates")
        write(directory, "docs/_templates/.gitkeep", "", verbose)

        c=ECR.render "src/templates/python/docs/index.rst.ecr"
        write(directory, "docs/index.rst", c, verbose)

        c=ECR.render "src/templates/python/docs/conf.py.ecr"
        write(directory, "docs/conf.py", c, verbose)

        c=ECR.render "src/templates/python/.readthedocs.yaml.ecr"
        write(directory, ".readthedocs.yaml", c, verbose)

        puts "#{"INFO:".colorize(:blue)} #{"Finished!".colorize(:green)}"
        puts "Examine #{"#{directory}/justfile".colorize(:blue)} for commands to run"
    end
end