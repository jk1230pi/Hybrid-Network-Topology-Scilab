clear
clc

adj = zeros(25,25);

for i = 1:9
    if i <> 5 then
        adj(5,i) = 1;
        adj(i,5) = 1;
    end
end

for i = 10:18
    adj(i,i+1) = 1;
    adj(i+1,i) = 1;
end
adj(19,10) = 1;
adj(10,19) = 1;

for i = 20:24
    adj(i,i+1) = 1;
    adj(i+1,i) = 1;
end

adj(5,10) = 1;  
adj(10,5) = 1;
adj(19,20) = 1; 
adj(20,19) = 1;

n = 25;
x = [];
y = [];

for i = 1:9
    if i == 5 then
        x = [x, -2];
        y = [y, 4];
    else
        ang = (i-1) * 2*%pi/8;
        x = [x, -2 + 2*cos(ang)];
        y = [y, 4 + 2*sin(ang)];
    end
end

for i = 10:19
    ang = (i-10) * 2*%pi/10;
    x = [x, 3 + 2.5*cos(ang)];
    y = [y, 2.5*sin(ang)];
end

for i = 20:25
    x = [x, 8 + (i-20)];
    y = [y, -1 + 0.3*(i-20)];
end

scf(1);
clf();

for i = 1:n
    for j = i+1:n
        if adj(i,j) == 1 then
            plot([x(i) x(j)], [y(i) y(j)], 'k-', 'thickness', 1);
        end
    end
end

for i = 1:9
    plot(x(i), y(i), 'ro', 'marksize', 10);
end
for i = 10:19
    plot(x(i), y(i), 'go', 'marksize', 10);
end
for i = 20:25
    plot(x(i), y(i), 'bo', 'marksize', 10);
end

for i = 1:n
    xstring(x(i)+0.1, y(i)+0.1, string(i));
end

title("Hybrid Topology (Star + Ring + Bus)");
axis("equal");
grid("on");
degrees = sum(adj, 2);

disp("Number of edges connected to each node:");
for i = 1:n
    mprintf("Node %2d : %2d edges\n", i, degrees(i));
end

[max_edges, max_node] = max(degrees);

mprintf("\nNode with maximum edges:\n");
mprintf("Node %d with %d edges\n", max_node, max_edges);

total_nodes = n;
total_edges = sum(adj) / 2;

mprintf("\nTotal number of nodes : %d\n", total_nodes);
mprintf("Total number of edges : %d\n", total_edges);
