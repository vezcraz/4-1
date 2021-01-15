#include <bits/stdc++.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>

using namespace std;

int startNodes, h;
class ForAll
{
public:
    int v[20][100000], pos[1000000], last[20], c[20], mp[100000];
    int countStopped = 0;
};
void initArr(int a[], int n, int val)
{
    for(int i = 0; i < n; i++)
        a[i] = val;
}
int32_t main()
{


    int startNodes = 4, h = 4;

    int shmid = shmget(IPC_PRIVATE, sizeof(ForAll), 0666 | IPC_CREAT);
    ForAll *f = (class ForAll *)shmat(shmid, (void *)0, 0);

    for(int i = 0; i < 20; i++)
        initArr(f->v[i], 100000, 0);
    initArr(f->pos, 1000000, 1);
    initArr(f->c, 20, 0);
    initArr(f->mp, 100000, -1);
    f->last[0] = 1;
    f->last[1] = startNodes;
    int produce = startNodes;
    for(int i = 2; i <= h; i++)
        f->last[i] = ((f->last[i - 1] + 1) * (f->last[i - 1])) / 2;
    for(int i = 0; i < h; i++)
        cout << f->last[i] << " ";
    cout << endl << endl;
    f->last[0] = startNodes;
    f->v[0][getpid()] = 1;
    int level = 0;
    for(int i = 0; i < produce; i++)
    {
        int x = fork();
        if(x == -1)
        {
            i--;
            continue;
        }
        else if(not x)
        {
            int curr = getpid();
            int par = getppid();
            int a = f->pos[par] - 1;
            f->pos[curr] = ((a * (a + 1)) / 2) + i + 1 ;
            produce = f->pos[curr];
            level++;
            // cout<<level<<endl;
            f->v[level][curr] = 1;
            if(level == h - 1) goto done;
            i = -1;
            cout << par << " " << a << " " << produce << endl;
            kill(curr, SIGSTOP);

        }
    }
    for(int i = 0; i < produce; i++)
    {
        waitpid(-1, NULL, WUNTRACED);
    }//waiting for all the children that are stopped
    while(1)
    {
        int count = 0;
        for(int i = 0; i < 1e5; i++)
        {
            if(f->v[level + 1][i] != 0) count++;
        }
        cout << count << " " << f->last[level + 1] << endl;
        if(count == f->last[level + 1]) break;
    }
    cout << level + 1 << " " << produce << " " << f->last[level] << " " <<
         endl << endl;
    if(produce == f->last[level]) //at the last node of the level
    {
        while(1)
        {
            int count = 0;
            for(int i = 0; i < 1e5; i++)
            {
                if(f->v[level + 1][i] != 0) count++;
            }
            cout << count << " " << f->last[level + 1] << endl;
            if(count == f->last[level + 1]) break;
        }
        cout << "HERE" << endl;
        for(int i = 0; i < 1e5; i++)
        {
            if(f->v[level + 1][i])
            {
                kill(i, SIGCONT);
            }
        }

    }
    cout << endl;
    while(wait(NULL) != -1);
    if(level == 0)
    {
        for(int i = 0; i < h; i++)
        {
            for(int j = 1; j < 1e5; j++)
            {
                if(f->v[i][j]) cout << j << " ";
            }
            cout << endl;
        }
    }
done:
    shmdt(f);
    shmctl(shmid, IPC_RMID, NULL);
}