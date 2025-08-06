import subprocess
import os

def get_git_root():
    try:
        git_root = subprocess.check_output(
            ["git", "rev-parse", "--show-toplevel"],
            text=True
        ).strip()
        return git_root
    except subprocess.CalledProcessError:
        raise RuntimeError("Not inside a Git repository")

def test_mytool_echo():
    git_root = get_git_root()
    bin_file = os.path.join(git_root, "bin", "release", "2048")

    if not os.path.isfile(bin_file):
        print(f"Couldn't find the binary: {os.path.abspath(bin_file)}")

    result = subprocess.run(
        [bin_file],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    assert result.returncode == 0
    assert "Hello, World!" in result.stdout

