Git Project
======
**Objective:**
You will work on a project involving a simple website. You will learn and practise various Git concepts including branching, merging, handling merge conflicts, rebasing, pulling, versioning, and rolling back changes. This project is designed to be completed in 1 hour.

#### Project Setup

1. **Install Git & Set Up Git:** 

- Ensure Git is installed on your system. Verify with 
```vim
git --version.
```
- Configure your Git username and email:
```vim
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.002.png)

2. **Create a GitHub Repository:**
- Go to GitHub and create a new repository named website-project.

Clone the repository to your local machine:
```
git clone https://github.com/your-username/website-project.git
```

3. **Initialize the Project**:

- Navigate to the project directory:

```bash
cd website-project
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.003.png)

Create initial project structure: 
```bash
mkdir src
touch src/index.html

echo "<!DOCTYPE html><html><head><title>My Website</title></head><body><h1>Welcome to my website!</h1></body></html>" > src/index.html
```
Commit and push the initial project structure: 
```
git add .
git commit -m "Initial commit: Added project structure and index.html"
git push origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.005.png)

## Exercise 1: Branching and Basic Operations

**Create a New Branch**:

> git checkout -b feature/add-about-page

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.006.png)

1. **Add a New Page**:

- Create about.html:

```bash
touch src/about.html
echo "<!DOCTYPE html><html><head><title>About Us</title></head><body><h1>About Us</h1></body></html>" > src/about.html
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.007.png)

- Commit and push changes:
```
git add src/about.html
git commit -m "Added about page"
git push origin feature/add-about-page
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.009.png)

## Exercise 2: Merging and Handling Merge Conflicts

- Create Another Branch:
```
git checkout master
git checkout -b feature/update-homepage
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.010.png)

1. **Update the Homepage**:

Modify index.html:
```bash
echo "<p>Updated homepage content</p>" >> src/index.html Commit and push changes:
git add src/index.html
git commit -m "Updated homepage content" git push origin feature/update-homepage
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.011.png)

2. **Create a Merge Conflict**:

Modify index.html on the feature/add-about-page branch: 
```bash
git checkout feature/add-about-page
echo "<p>Conflict content</p>" >> src/index.html
git add src/index.html
git commit -m "Added conflicting content to homepage" git push origin feature/add-about-page
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.012.png)

3. **Merge and Resolve Conflict**:

Attempt to merge feature/add-about-page into master:
```bash
git checkout master
git merge feature/add-about-page git push origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.013.png)

## Exercise 3: Rebasing

1. **Rebase a Branch**:

Rebase feature/update-homepage onto master:
```bash
git checkout feature/update-homepage 
git rebase master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.015.png)

- Resolve any conflicts that arise during rebase.

**Push the Rebased Branch**:
```bash
git push -f origin feature/update-homepage
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.016.png)

## Exercise 4: Pulling and Collaboration

1. **Pull Changes from Remote**:

Ensure the master branch is up-to-date:
```bash
git checkout master git pull origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.018.png)

2. **Simulate a Collaborator's Change**:
- Make a change on GitHub directly (e.g., edit index.html).
3. **Pull Collaborator's Changes**:

Pull the changes made by the collaborator: 
```
git pull origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.019.png)

## Exercise 5: Versioning and Rollback

1. **Tagging a Version**:

Tag the current commit as v1.0:
```
git tag -a v1.0 -m "Version 1.0: Initial release" 
git push origin v1.0
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.021.png)

2. **Make a Change that Needs Reversion**:

Modify index.html:
```
echo "<p>Incorrect update</p>" >> src/index.html git add src/index.html
git commit -m "Incorrect update" 
git push origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.022.png)

3. **Revert to a Previous Version**:

Use git revert to undo the last commit:
```
git revert HEAD
git push origin master
git reset --hard v1.0
git push -f origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.023.png)

**Extra Activities**

1. **Stashing Changes**:

Make some local changes without committing:

> echo "<p>Uncommitted changes</p>" >> src/index.html 

Stash the changes:

> git stash

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.025.png)

Apply the stashed changes: 
```
git stash apply
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.026.png)

2. **Viewing Commit History**:

Use git log to view commit history: 
```
git log --oneline
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.027.png)

3. **Cherry-Picking Commits**:

Create a new branch and cherry-pick a commit from another branch and solving the conflict if any:
```
git checkout -b feature/cherry-pick
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.028.png)
```
git cherry-pick <commit-hash> git cherry-pick --continue
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.029.png)
```
git push origin feature/cherry-pick
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.030.png)

4. **Interactive Rebase**:

Use interactive rebase to squash commits:
```
git checkout master git rebase -i HEAD~3
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.031.png)

**Collaborative Blogging Platform**
=====

**Objective:**

You will work on a project to collaboratively develop a simple blogging platform. You will practice various Git concepts including branching, merging, handling merge conflicts, rebasing, pulling, versioning, rolling back changes, stashing, and cherry-picking commits. The project is designed to be completed in 1.5 Hours

1. **Create a GitHub Repository**:
- Go to GitHub and create a new repository named blogging-platform.

Clone the repository to your local machine:

> git clone https://github.com/your-username/blogging-platform.git

2. **Initialize the Project**:

Navigate to the project directory: 
> cd blogging-platform

Create initial project structure: 
```bash
mkdir src
touch src/index.html
echo "<!DOCTYPE html><html><head><title>Blogging Platform</title></head><body><h1>Welcome to the Blogging Platform! </h1></body></html>" > src/index.html
```
Commit and push the initial project structure: 
```
git add .
git commit -m "Initial commit: Added project structure and index.html"
git push origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.034.png)

## Exercise 1: Branching and Adding Features

**Create a New Branch for Blog Post Feature**: 
```
git checkout -b feature/add-blog-post
```

1. **Add a Blog Post Page**:

Create blog.html:
```bash
touch src/blog.html
echo "<!DOCTYPE html><html><head><title>Blog Post</title></head><body><h1>My First Blog Post</h1></body></html>" > src/blog.html
```
Commit and push changes:

```
git add src/blog.html
git commit -m "Added blog post page" git push origin feature/add-blog-post![ref2]
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.035.png)

## Exercise 2: Collaborating with Merging and Handling Merge Conflicts 

1. **Create Another Branch for Author Info**:

```
git checkout master
git checkout -b feature/add-author-info
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.036.png)

2. **Add Author Info to Blog Page**:

Modify blog.html:
```bash
echo "<p>Author: John Doe</p>" >> src/blog.html Commit and push changes:
git add src/blog.html
git commit -m "Added author info to blog post" git push origin feature/add-author-info
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.037.png)

3. **Create a Merge Conflict**:

Modify blog.html on the feature/add-blog-post branch:
```bash
git checkout feature/add-blog-post
echo "<p>Published on: July 10, 2024</p>" >> src/blog.html git add src/blog.html
git commit -m "Added publish date to blog post"
git push origin feature/add-blog-post
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.038.png)

4. **Merge and Resolve Conflict**:

Attempt to merge feature/add-blog-post into master: 
```
git checkout master
git merge feature/add-blog-post
git push origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.039.png)

## Exercise 3: Rebasing and Feature Enhancement

1. **Rebase a Branch for Comment Feature**:

Rebase feature/add-author-info onto master:
```
git checkout feature/add-author-info
git rebase master
```

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.041.png)

- Resolve any conflicts that arise during rebase.

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.042.png)

2. **Add Comment Section**:

Modify blog.html to add a comment section:
```bash
echo "<h2>Comments</h2><p>No comments yet.</p>" >> src/blog.html git add src/blog.html
git commit -m "Added comment section"
git push origin feature/add-author-info
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.043.png)

## Exercise 4: Pulling and Simulating Collaboration

1. **Pull Changes from Remote**:

Ensure the master branch is up-to-date:
```
git checkout master git pull origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.045.png)

2. **Simulate a Collaborator's Change**:
- Make a change on GitHub directly (e.g., edit blog.html to add a new comment).
3. **Pull Collaborator's Changes**:

Pull the changes made by the collaborator: 
```
git pull origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.046.png)

## Exercise 5: Versioning and Rollback

1. **Tagging a Version**:

Tag the current commit as v1.0:
```
git tag -a v1.0 -m "Version 1.0: Initial release" 
git push origin v1.0
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.047.png)

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.048.png)

2. **Make a Change that Needs Reversion**:

Modify blog.html:
```bash
echo "<p>Incorrect comment</p>" >> src/blog.html git add src/blog.html
git commit -m "Incorrect comment update"
git push origin master
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.049.png)

3. **Revert to a Previous Version**:

Use git revert to undo the last commit:
```
git revert HEAD
git push origin master
```
Alternatively, reset to a specific commit (use with caution:git reset --hard v1.0)

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.050.png)

**Extra Activities**

1. **Stashing Changes**:

Make some local changes without committing:
```bash
echo "<p>Uncommitted changes</p>" >> src/blog.html Stash the changes:
git stash
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.051.png)

Apply the stashed changes: git stash apply

![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.052.png)

2. **Viewing Commit History**:

Use git log to view commit history: 
```
git log --oneline
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.053.png)

3. **Cherry-Picking Commits**:

Create a new branch and cherry-pick a commit from another branch: 
```
git checkout -b feature/cherry-pick
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.054.png)
```
git cherry-pick <commit-hash>
git push origin feature/cherry-pick
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.055.png)

4. **Interactive Rebase**:

Use interactive rebase to squash commits: 
```
git checkout master
git rebase -i HEAD~3
```
![](img/Aspose.Words.effd7880-22fc-4aa9-9726-80480e66935c.056.png)